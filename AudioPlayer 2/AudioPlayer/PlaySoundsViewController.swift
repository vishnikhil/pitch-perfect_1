//
//  PlaySoundsViewController.swift
//  AudioPlayer
//
//  Created by Vishruti Kekre on 12/15/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    var audioPlayer2 : AVAudioPlayer!
    var audioPlayer: AVAudioPlayer!
    var receivedAudio : RecordedAudio!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate=true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl,error:nil)
        audioPlayer2 = AVAudioPlayer(contentsOfURL : receivedAudio.filePathUrl , error:nil)
       
    }
 
    
    
//    Plays slow Audio
      @IBAction func playSlowAudio(sender: UIButton) {
       audioEngine.stop()
       audioPlayer.stop()
       audioPlayer.currentTime=0.0
       audioPlayer.rate=0.5
        audioPlayer.play()
       audioEngine.reset()
        
    }
    
//    Plays Fast Audio
      @IBAction func playFastAudio(sender: UIButton) {
      audioEngine.stop()
      audioPlayer.stop()
      audioPlayer.currentTime=0.0
      audioPlayer.rate=1.5
     
      audioPlayer.play()
      audioEngine.reset()
        
    }
    
// Stops the Audio
     @IBAction func stopAudio(sender: UIButton) {
     audioEngine.stop()
     audioPlayer.stop()
     audioEngine.reset()
     audioPlayer2.stop()
    }
    
    
    
//    Changes the Pitch of the Sound
       func playAudioWithVariablePitch(pitch : Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
       
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        
        audioEngine.connect(changePitchEffect,to: audioEngine.outputNode,format:nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
       
    }
    
//    Plays chipmunk effect
        func playChipmunkAudio(pitch : Float) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        playAudioWithVariablePitch(1000)
        
    }

    
//    Plays DarthVader effect
        @IBAction func playDarthsound(sender: UIButton) {
        audioPlayer.stop()
        playAudioWithVariablePitch(-1000)
       
    }
    
    
    
//    This function plays an echo effect
        @IBAction func playEcho(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.play()
        let delay : NSTimeInterval = 0.8
        var playtime : NSTimeInterval
        playtime = audioPlayer2.deviceCurrentTime + delay
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 1.0
        audioPlayer2.play()
        audioPlayer2.playAtTime(playtime)
            
    }
    
    
//    This func plays an reverb effect
        @IBAction func playReverbButton(sender: UIButton) {
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0.0
        playEffect()

    }
    
    func playEffect(){
    
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0

        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
//        Add the reverb effect to the audioEngine before you connect
        var effect = AVAudioUnitReverb()
        audioEngine.attachNode(effect)
        
        var effect2 = AVAudioUnitDelay()
        audioEngine.attachNode(effect2)
        audioEngine.connect(audioPlayerNode, to: effect2,format: nil)
        audioEngine.connect(effect2, to:audioEngine.outputNode,format:nil)
        
       audioPlayerNode.scheduleFile(audioFile,atTime:nil,completionHandler:nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
        
    }
    
    
}
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
   

