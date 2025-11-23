public class Solution {

import java.util.*;

public class Solution {
    public int hardestButton(String[] releaseTimes, String[] keysPressed) {
        int maxTime = 0;
        char hardestChar = 'a';
        int prevTime = 0;

        for (int i = 0; i < releaseTimes.length; i++) {
            int currentTime = Integer.parseInt(releaseTimes[i]);
            int duration = currentTime - prevTime;
            if (duration > maxTime || (duration == maxTime && keysPressed[i] < hardestChar)) {
                maxTime = duration;
                hardestChar = keysPressed[i];
            }
            prevTime = currentTime;
        }

        return hardestChar;
    }
}
}