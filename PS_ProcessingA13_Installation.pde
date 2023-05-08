//Plant Symphony
//an interactive sound installation

//test 
//test May 8
//new line
//another new line

import processing.serial.*;

Serial port; // Create object from Serial class
PFont titleFont, staticDisplayFont, dataFont;  // Create a font object to display text

//for sound
import ddf.minim.*;

Minim minim;

//for sound files
AudioSample level1_G3;
AudioSample level2_ChordG3;
AudioSample level3_ChordC5;
AudioSample level4_ChordE5;
AudioSample level5_ChordF5;
AudioSample level6_ChordG5;
AudioSample cactus;

AudioPlayer loopBaseNote;


//----------------------------------------for layout

//horizontal allignment
int xGap = 500;//space between collumns
int xleft = 160;
int dataValSpacer = xleft+4;
int xleftDataVal = xleft + xleft;
int xmiddle = xleft+ xGap;
int xmiddleDataVal = xmiddle + dataValSpacer;
int xright = xmiddle + xGap;
int xrightDataVal = xright + dataValSpacer;

//virtical allignment
int yGap = 35;
int yTextRow1 = 155;
int yTextRow2 = yTextRow1 + yGap;
int yTextRow3 = yTextRow2 + yGap;
int yTextRow4 = yTextRow3 + yGap;
int yTextRow5 = yTextRow1 + yTextRow3;
int yTextRow6 = yTextRow5 + yGap;
int yTextRow7 = yTextRow6 + yGap;
int yTextRow8 = yTextRow7 + yGap;

//circle dimenstions
int circleTextGap = 70;
int xCenterLeft = xleft - circleTextGap;
int xCenterMiddle = xmiddle - circleTextGap;
int xCenterRight = xright - circleTextGap;
int yCenterTopRow = yTextRow2+5;
int yCenterBottomRow = yTextRow6 +5;
int circleDiameter = 100;

//----------------------------------plants

//list of plants
int plant1; //fern, red lead, pin 2D pin 3PWM
int plant2; //large leaf, green lead, pin 4D pin 5PWM
int plant3; //spikey, black lead, pin 7 pin 6PWM
int plant4; //tree. yellow lead, pin 8D pin 9PWM
int plant5; //cactus, blue lead, pin 12D pin 11PWM


byte[] inBuffer = new byte[255]; //size of the serial buffer to allow for end of data characters and all chars (see arduino code)

void setup() {
  size(1500, 600); //size of window
  noStroke();
  frameRate(10); // Run 10 frames per second

  //font file has to be in the same folder as sketch (go Tools/ CreateFont/etc...)
  titleFont = loadFont("NirmalaUI-28.vlw");
  staticDisplayFont = loadFont("NirmalaUI-Semilight-24.vlw");
  dataFont = loadFont("NirmalaUI-Bold-24.vlw");


  // Open the port that the board is connected to and use the same speed (9600 bps)
  port = new Serial(this, Serial.list()[0], 9600);


  //-----------------sound for plants
  minim = new Minim(this);
  

  // load level1_G3 for continual play
  loopBaseNote = minim.loadFile("G3_BaseSoundLoop.mp3", 1024);
  if (level1_G3 == null ) println("noteG3 not played");
  loopBaseNote.loop();
  
   // load level1_G3 - good
  level1_G3 = minim.loadSample("Sound1_G3.mp3", 1024);
  if (level1_G3 == null ) println("noteG3 not played");

  //load level2_ChordG3 - good
  level2_ChordG3 = minim.loadSample("sound3_G3chord.mp3", 1024);
  if (level2_ChordG3 == null ) println("note chord G3 not played");

  //load level3_ChordC5 - good
  level3_ChordC5 = minim.loadSample("sound8_ChordC5.mp3", 1024);
  if (level3_ChordC5 == null ) println("note chord C5 not played");
  
  //load level4_ChordE5 - good
  level4_ChordE5 = minim.loadSample("sound9_ChordE5.mp3", 1024);
  if (level4_ChordE5 == null ) println("note chord E5 not played");

  //load level5_ChordF5 - good
  level5_ChordF5 = minim.loadSample("sound10_ChordF5.mp3", 1024);
  if (level5_ChordF5 == null ) println("note chord F5 not played");

  //load level6_ChordG5 - good
  level6_ChordG5 = minim.loadSample("sound11_ChordG5.mp3", 1024);
  if (level6_ChordG5 == null ) println("note chord G5 not played");

  ////load cactus/warning
  cactus = minim.loadSample("CactusV2.mp3", 1024);
  if (cactus == null ) println("note 12 not played");

}




void draw() {
  if (0 < port.available()) { // If data is available to read,

    println(" ");

    port.readBytesUntil('&', inBuffer);  //read in all data until '&' is encountered

    if (inBuffer != null) {
      String myString = new String(inBuffer);
      //println(myString);  //for testing only

      //p is all sensor data (with a's and b's) ('&' is eliminated) ///////////////

      String[] p = splitTokens(myString, "&");
      if (p.length < 2) return;  //exit this function if packet is broken
      //println(p[0]);   //for testing only


      // --------------------------------Plant 1 sensor readings

      String[] plantSensor1 = splitTokens(p[0], "a");  //get plant1 reading
      if (plantSensor1.length != 3) return;  //exit this function if packet is broken
      plant1 = int(plantSensor1[1]);

      //Console display
      print("plant1 sensor:");
      print(plant1);
      println(" ");


      // --------------------------------Plant 2 sensor readings

      String[] plantSensor2 = splitTokens(p[0], "b");  //get slider sensor reading
      if (plantSensor2.length != 3) return;  //exit this function if packet is broken
      //println(slider_sensor[1]);
      plant2 = int(plantSensor2[1]);

      //Console display
      print("plant2 sensor:");
      print(plant2);
      println(" ");


      // --------------------------------Plant 3 sensor readings

      String[] plantSensor3 = splitTokens(p[0], "c");  //get slider sensor reading
      if (plantSensor3.length != 3) return;  //exit this function if packet is broken
      //println(slider_sensor[1]);
      plant3 = int(plantSensor3[1]);

      //Console display
      print("plant3 sensor:");
      print(plant3);
      println(" ");


      // --------------------------------Plant 4 sensor readings

      String[] plantSensor4 = splitTokens(p[0], "d");  //get slider sensor reading
      if (plantSensor4.length != 3) return;  //exit this function if packet is broken
      //println(slider_sensor[1]);
      plant4 = int(plantSensor4[1]);

      //Console display
      print("plant4 sensor:");
      print(plant4);
      println(" ");


      // --------------------------------Plant 5 sensor readings

      String[] plantSensor5 = splitTokens(p[0], "e");  //get slider sensor reading
      if (plantSensor5.length != 3) return;  //exit this function if packet is broken
      //println(slider_sensor[1]);
      plant5 = int(plantSensor5[1]);

      //Console display
      print("plant5 sensor:");
      print(plant5);
      println(" ");


      //display data
      //dashboard(plant1, plant2, plant3, plant4);
     dashboard(plant1, plant2, plant3, plant4, plant5);
      //dashboard(plant1);//for testing
    }//end if buffer

    //trigger notes
    playNotes();
  }//end outer if
}//end


//the value from the capacitance senors will trigger sound
//each level is 150 in value with a buffer of 20 inbetween for smoother transitions
void playNotes() {



  //---------------------Plant 1 - Fern
  //red lead
  //one touch has low sensor values ~ 140
  //buffer 10
  //range 100 - 200

  //if (plant1>15 && plant1<70)  level1_G3.trigger();
  if (plant1> 80 && plant1<310) level2_ChordG3.trigger();
  if (plant1>320 && plant1<620) level3_ChordC5.trigger();
  if (plant1>630 && plant1<940) level4_ChordE5.trigger();
  if (plant1>950 && plant1<1250) level5_ChordF5.trigger();
  //if (plant1>860 && plant1<860) level6_ChordG5.trigger();
  if (plant1>1280)  level6_ChordG5.trigger();
  //if (plant1>980) cactus.trigger();


  //---------------------Plant 2 - big leafy
  //green lead
  //one touch ~150
  //buffer 10
  //range 100 - 200

  //if (plant2>10 && plant2<100)  level1_G3.trigger();
  if (plant2>80 && plant2<510) level2_ChordG3.trigger();
  if (plant2>520 && plant2<1020) level3_ChordC5.trigger();
  if (plant2>1030 && plant2<1340) level4_ChordE5.trigger();
  if (plant2>1350 && plant2<1750) level5_ChordF5.trigger();
  if (plant2>1760) level6_ChordG5.trigger();
  //if (plant2<870) cactus.trigger();


 
  //---------------------Plant 3 - spikey
  //black lead
  //one touch ~50
  //buffer 20
  //range 100
  

  //if (plant3>5 && plant3<50)  level1_G3.trigger();
  if (plant3>60 && plant3<160) level2_ChordG3.trigger();
  if (plant3>180 && plant3<280) level3_ChordC5.trigger();
  if (plant3>300 && plant3<400) level4_ChordE5.trigger();
  if (plant3>420 && plant3<520) level5_ChordF5.trigger();
  if (plant3>540 && plant3<640) level6_ChordG5.trigger();
  //if (plant3>650) cactus.trigger();



  //---------------------Plant 4 - tree -- adjust these values Monday
  //yellow lead
  //one touch ~150
  //buffer 20
  //range 300
  
  
   //if (plant4>10 && plant4<100)  level1_G3.trigger();
  //if (plant4>150 && plant4<610) level2_ChordG3.trigger();
  if (plant4>620 && plant4<820) level3_ChordC5.trigger();
  if (plant4>830 && plant4<1240) level4_ChordE5.trigger();
  if (plant4>1250 && plant4<1750) level5_ChordF5.trigger();
  if (plant4>1760 && plant4<3000) level6_ChordG5.trigger();
  //if (plant4<2020) cactus.trigger();


  //---------------------Plant 5 - cactus
  //blue lead
  //one touch ~60
  //buffer 5
  //range 15


 if (plant5>50) cactus.trigger();
 //if (plant5>50)level2_ChordG3.trigger();
 
  
}//end playNotes




//display for all 5 plants
//use last method below for testing one plant at a time
//void dashboard(int plant1, int plant2, int plant3, int plant4) {
void dashboard(int plant1, int plant2, int plant3, int plant4, int plant5) {

  //display screen for data

  background(255); // Clear background
  fill(0);
  stroke(0);

  //title
  textFont(titleFont);
  text("Plant Symphony Data Display", 40, 40);

  //plant 1
  fill(0);
  textFont(staticDisplayFont);
  text("Plant 1 - Fern", xleft, yTextRow1);
  text("wire lead color: red", xleft, yTextRow2);
  text("plant1 sensor: ", xleft, yTextRow3);
  textFont(dataFont);
  text(plant1, xleftDataVal, yTextRow3);
  //textFont(staticDisplayFont);
  //text("note triggered: add here", xleft, yTextRow4);

  //circle fill changes with sensor value to give quick indication of value change, does not match sensor value
  fill(0, 255, 0, plant1);
  ellipse(xCenterLeft, yCenterTopRow, circleDiameter, circleDiameter);


  //plant 2
  fill(0);
  textFont(staticDisplayFont);
  text("Plant 2 - big leafy", xmiddle, yTextRow1);
  text("wire lead color: green", xmiddle, yTextRow2);
  text("plant2 sensor: ", xmiddle, yTextRow3);
  textFont(dataFont);
  text(plant2, xmiddleDataVal, yTextRow3);
  //textFont(staticDisplayFont);
  //text("note triggered: add here", xmiddle, yTextRow4);

  //circle fill changes with sensor value to give quick indication of value change, does not match sensor value
  fill(0, 255, 0, plant1);
  ellipse(xCenterMiddle, yCenterTopRow, circleDiameter, circleDiameter);



  //plant 3
  fill(0);
  textFont(staticDisplayFont);
  text("Plant 3", xright, yTextRow1);
  text("wire lead color: black", xright, yTextRow2);
  text("plant3 sensor: ", xright, yTextRow3);
  textFont(dataFont);
  text(plant3, xrightDataVal, yTextRow3);
  //textFont(staticDisplayFont);
  //text("note triggered: add here", xright, yTextRow4);

  //circle fill changes with sensor value to give quick indication of value change, does not match sensor value
  fill(0, 255, 0, plant3);
  ellipse(xCenterRight, yCenterTopRow, circleDiameter, circleDiameter);


  //plant 4
  fill(0);
  textFont(staticDisplayFont);
  text("Plant 4", xleft, yTextRow5);
  text("wire lead color: yellow", xleft, yTextRow6);
  text("plant4 sensor: ", xleft, yTextRow7);
  textFont(dataFont);
  text(plant4, xleftDataVal+4, yTextRow7);
  //textFont(staticDisplayFont);
  //text("note triggered: add here", xleft, yTextRow8);

  //circle fill changes with sensor value to give quick indication of value change, does not match sensor value
  fill(0, 255, 0, plant4);
  ellipse(xCenterLeft, yCenterBottomRow, circleDiameter, circleDiameter);


  //plant 5
  fill(0);
  textFont(staticDisplayFont);
  text("Plant 5", xmiddle, yTextRow5);
  text("wire lead color: blue", xmiddle, yTextRow6);
  text("plant5 sensor: ", xmiddle, yTextRow7);
  textFont(dataFont);
  text(plant5, xmiddleDataVal, yTextRow7);
  //textFont(staticDisplayFont);
  //text("note triggered: add here", xmiddle, yTextRow8);

  //circle fill changes with sensor value to give quick indication of value change, does not match sensor value
  fill(0, 255, 0, plant5);
  ellipse(xCenterMiddle, yCenterBottomRow, circleDiameter, circleDiameter);
}



//for trouble shooting
void keyPressed()
{
  

  if ( key == '1' ) level1_G3.trigger();
  if ( key == '2' ) level2_ChordG3.trigger();
  if ( key == '3' ) level3_ChordC5.trigger();
  if ( key == '4' ) level4_ChordE5.trigger();
  if ( key == '5' ) level5_ChordF5.trigger();
  if ( key == '6' ) level6_ChordG5.trigger();
  if ( key == '7' ) cactus.trigger();

  println("key pressed " + key);
}



/*
//---------------------------------testing for 1 plant use red lead wire
 //display
 void dashboard(int plant1) {
 
 //display screen for data
 
 background(255); // Clear background
 fill(0);
 stroke(0);
 
 //title
 textFont(titleFont);
 text("Plant Symphony Data Display", 40, 40);
 
 //plant 1
 fill(0);
 textFont(staticDisplayFont);
 text("Plant 1", xleft, yTextRow1);
 text("wire lead color: add here", xleft, yTextRow2);
 text("plant1 sensor: ", xleft, yTextRow3);
 textFont(dataFont);
 text(plant1, xleftDataVal, yTextRow3);
 textFont(staticDisplayFont);
 text("note triggered: add here", xleft, yTextRow4);
 
 //circle fill changes with sensor value to give quick indication of value change, does not match sensor value
 fill(0, 255, 0, plant1);
 ellipse(xCenterLeft, yCenterTopRow, circleDiameter, circleDiameter);
 
 
 //plant 2
 fill(0);
 textFont(staticDisplayFont);
 text("Plant 2", xmiddle, yTextRow1);
 text("wire lead color: add here", xmiddle, yTextRow2);
 text("plant2 sensor: ", xmiddle, yTextRow3);
 textFont(dataFont);
 text(plant1, xmiddleDataVal, yTextRow3);
 textFont(staticDisplayFont);
 text("note triggered: add here", xmiddle, yTextRow4);
 
 //circle fill changes with sensor value to give quick indication of value change, does not match sensor value
 fill(0, 255, 0, plant1);
 ellipse(xCenterMiddle, yCenterTopRow, circleDiameter, circleDiameter);
 
 
 //plant 1 and 2 used for display demo, change when plants are added
 
 
 //plant 3
 fill(0);
 textFont(staticDisplayFont);
 text("Plant 3", xright, yTextRow1);
 text("wire lead color: add here", xright, yTextRow2);
 text("plant3 sensor: ", xright, yTextRow3);
 textFont(dataFont);
 text(plant1, xrightDataVal, yTextRow3);
 textFont(staticDisplayFont);
 text("note triggered: add here", xright, yTextRow4);
 
 //circle fill changes with sensor value to give quick indication of value change, does not match sensor value
 fill(0, 255, 0, plant1);
 ellipse(xCenterRight, yCenterTopRow, circleDiameter, circleDiameter);
 
 
 //plant 4
 fill(0);
 textFont(staticDisplayFont);
 text("Plant 4", xleft, yTextRow5);
 text("wire lead color: add here", xleft, yTextRow6);
 text("plant4 sensor: ", xleft, yTextRow7);
 textFont(dataFont);
 text(plant1, xleftDataVal+4, yTextRow7);
 textFont(staticDisplayFont);
 text("note triggered: add here", xleft, yTextRow8);
 
 //circle fill changes with sensor value to give quick indication of value change, does not match sensor value
 fill(0, 255, 0, plant1);
 ellipse(xCenterLeft, yCenterBottomRow, circleDiameter, circleDiameter);
 
 
 //plant 5
 fill(0);
 textFont(staticDisplayFont);
 text("Plant 5", xmiddle, yTextRow5);
 text("wire lead color: add here", xmiddle, yTextRow6);
 text("plant5 sensor: ", xmiddle, yTextRow7);
 textFont(dataFont);
 text(plant1, xmiddleDataVal, yTextRow7);
 textFont(staticDisplayFont);
 text("note triggered: add here", xmiddle, yTextRow8);
 
 //circle fill changes with sensor value to give quick indication of value change, does not match sensor value
 fill(0, 255, 0, plant1);
 ellipse(xCenterMiddle, yCenterBottomRow, circleDiameter, circleDiameter);
 }
 */
