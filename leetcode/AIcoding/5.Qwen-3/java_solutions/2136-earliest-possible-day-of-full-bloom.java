public class Solution {

import java.util.*;

public class Solution {
    public int earliestFullBloom(int[] plantTime, int[] growTime) {
        int n = plantTime.length;
        int[][] pairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i][0] = plantTime[i];
            pairs[i][1] = growTime[i];
        }
        Arrays.sort(pairs, (a, b) -> b[1] - a[1]);
        int day = 0;
        int maxDay = 0;
        for (int i = 0; i < n; i++) {
            day += pairs[i][0];
            maxDay = Math.max(maxDay, day + pairs[i][1]);
        }
        return maxDay;
    }
}
}