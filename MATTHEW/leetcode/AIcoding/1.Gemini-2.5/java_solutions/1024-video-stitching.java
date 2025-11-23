import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int videoStitching(int[][] clips, int time) {
        if (time == 0) {
            return 0;
        }

        Arrays.sort(clips, Comparator.comparingInt(a -> a[0]));

        int clipsCount = 0;
        int currentReach = 0; 
        int i = 0; 

        while (currentReach < time) {
            clipsCount++;
            int maxReachInStep = currentReach; 

            while (i < clips.length && clips[i][0] <= currentReach) {
                maxReachInStep = Math.max(maxReachInStep, clips[i][1]);
                i++;
            }

            if (maxReachInStep <= currentReach) {
                return -1;
            }

            currentReach = maxReachInStep;

            if (currentReach >= time) {
                return clipsCount;
            }
        }

        return -1; 
    }
}