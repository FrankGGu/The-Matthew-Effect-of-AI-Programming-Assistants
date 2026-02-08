public class Solution {

import java.util.*;

public class Solution {
    public int hardestWorker(int n, int[][] logs) {
        int maxTime = 0;
        int result = 0;
        int prevTime = 0;

        for (int[] log : logs) {
            int userId = log[0];
            int time = log[1];
            int duration = time - prevTime;

            if (duration > maxTime) {
                maxTime = duration;
                result = userId;
            } else if (duration == maxTime && userId < result) {
                result = userId;
            }

            prevTime = time;
        }

        return result;
    }
}
}