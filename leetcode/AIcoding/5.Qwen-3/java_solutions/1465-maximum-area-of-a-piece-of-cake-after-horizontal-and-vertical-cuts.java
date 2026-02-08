public class Solution {

import java.util.Arrays;

public class Solution {
    public int maxArea(int h, int w, int[] horizontalCuts, int[] verticalCuts) {
        Arrays.sort(horizontalCuts);
        Arrays.sort(verticalCuts);

        int maxH = 0;
        int prev = 0;
        for (int cut : horizontalCuts) {
            maxH = Math.max(maxH, cut - prev);
            prev = cut;
        }
        maxH = Math.max(maxH, h - prev);

        int maxW = 0;
        prev = 0;
        for (int cut : verticalCuts) {
            maxW = Math.max(maxW, cut - prev);
            prev = cut;
        }
        maxW = Math.max(maxW, w - prev);

        return maxH * maxW;
    }
}
}