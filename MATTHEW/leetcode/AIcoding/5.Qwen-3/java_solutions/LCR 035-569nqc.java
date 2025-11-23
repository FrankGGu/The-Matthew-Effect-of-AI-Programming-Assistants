public class Solution {

import java.util.Arrays;

public class Solution {
    public int findMinDifference(String[] timePoints) {
        int n = timePoints.length;
        Arrays.sort(timePoints);
        int minDiff = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            String[] time1 = timePoints[i].split(":");
            String[] time2 = timePoints[(i + 1) % n].split(":");
            int h1 = Integer.parseInt(time1[0]);
            int m1 = Integer.parseInt(time1[1]);
            int h2 = Integer.parseInt(time2[0]);
            int m2 = Integer.parseInt(time2[1]);
            int diff = Math.abs((h1 * 60 + m1) - (h2 * 60 + m2));
            minDiff = Math.min(minDiff, diff);
        }
        return minDiff;
    }
}
}