import java.util.Arrays;

class Solution {
    public int maximizeSquareHoleArea(int n, int m, int[] hBars, int[] vBars) {
        Arrays.sort(hBars);
        Arrays.sort(vBars);

        int maxHorizontal = 0;
        int currentHorizontal = 1;
        for (int i = 1; i < hBars.length; i++) {
            if (hBars[i] == hBars[i - 1] + 1) {
                currentHorizontal++;
            } else {
                maxHorizontal = Math.max(maxHorizontal, currentHorizontal);
                currentHorizontal = 1;
            }
        }
        maxHorizontal = Math.max(maxHorizontal, currentHorizontal);

        int maxVertical = 0;
        int currentVertical = 1;
        for (int i = 1; i < vBars.length; i++) {
            if (vBars[i] == vBars[i - 1] + 1) {
                currentVertical++;
            } else {
                maxVertical = Math.max(maxVertical, currentVertical);
                currentVertical = 1;
            }
        }
        maxVertical = Math.max(maxVertical, currentVertical);

        int side = Math.min(maxHorizontal + 1, maxVertical + 1);
        return side * side;
    }
}