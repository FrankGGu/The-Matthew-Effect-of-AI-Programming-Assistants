public class Solution {

import java.util.Arrays;

public class Solution {
    public int minCost(int n, int[] horizontalCuts, int[] verticalCuts) {
        Arrays.sort(horizontalCuts);
        Arrays.sort(verticalCuts);

        int maxH = 0;
        int prev = 0;
        for (int cut : horizontalCuts) {
            maxH = Math.max(maxH, cut - prev);
            prev = cut;
        }
        maxH = Math.max(maxH, n - prev);

        int maxV = 0;
        prev = 0;
        for (int cut : verticalCuts) {
            maxV = Math.max(maxV, cut - prev);
            prev = cut;
        }
        maxV = Math.max(maxV, n - prev);

        return maxH * maxV;
    }
}
}