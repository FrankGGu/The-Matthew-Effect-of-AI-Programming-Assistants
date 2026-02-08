import java.util.Arrays;

class Solution {
    public int maxArea(int h, int w, int[] horizontalCuts, int[] verticalCuts) {
        Arrays.sort(horizontalCuts);
        Arrays.sort(verticalCuts);

        long maxHeight = 0;
        long maxWidth = 0;

        long prevH = 0;
        for (int cut : horizontalCuts) {
            maxHeight = Math.max(maxHeight, cut - prevH);
            prevH = cut;
        }
        maxHeight = Math.max(maxHeight, h - prevH);

        long prevW = 0;
        for (int cut : verticalCuts) {
            maxWidth = Math.max(maxWidth, cut - prevW);
            prevW = cut;
        }
        maxWidth = Math.max(maxWidth, w - prevW);

        long MOD = 1_000_000_007;

        return (int) ((maxHeight * maxWidth) % MOD);
    }
}