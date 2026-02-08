public class Solution {

import java.util.*;

public class Solution {
    public char slowestKey(int[] releaseTimes, String keyPresses) {
        int maxDuration = releaseTimes[0];
        char slowestKey = keyPresses.charAt(0);

        for (int i = 1; i < releaseTimes.length; i++) {
            int duration = releaseTimes[i] - releaseTimes[i - 1];
            if (duration > maxDuration) {
                maxDuration = duration;
                slowestKey = keyPresses.charAt(i);
            } else if (duration == maxDuration) {
                if (keyPresses.charAt(i) > slowestKey) {
                    slowestKey = keyPresses.charAt(i);
                }
            }
        }

        return slowestKey;
    }
}
}