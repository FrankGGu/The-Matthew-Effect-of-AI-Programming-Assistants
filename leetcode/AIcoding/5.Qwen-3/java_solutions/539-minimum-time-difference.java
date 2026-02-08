public class Solution {

import java.util.*;

public class Solution {
    public String findMinDifference(List<String> timePoints) {
        Collections.sort(timePoints);
        int minDiff = Integer.MAX_VALUE;
        for (int i = 0; i < timePoints.size(); i++) {
            String[] t1 = timePoints.get(i).split(":");
            int h1 = Integer.parseInt(t1[0]);
            int m1 = Integer.parseInt(t1[1]);
            int total1 = h1 * 60 + m1;
            String[] t2 = timePoints.get((i + 1) % timePoints.size()).split(":");
            int h2 = Integer.parseInt(t2[0]);
            int m2 = Integer.parseInt(t2[1]);
            int total2 = h2 * 60 + m2;
            int diff = Math.abs(total1 - total2);
            minDiff = Math.min(minDiff, diff);
        }
        return String.valueOf(minDiff);
    }
}
}