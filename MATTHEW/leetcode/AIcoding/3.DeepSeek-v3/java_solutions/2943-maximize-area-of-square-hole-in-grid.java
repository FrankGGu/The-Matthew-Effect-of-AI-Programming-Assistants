import java.util.Arrays;

class Solution {
    public int maximizeSquareHoleArea(int n, int m, int[] hBars, int[] vBars) {
        Arrays.sort(hBars);
        Arrays.sort(vBars);

        int maxH = getMaxConsecutive(hBars);
        int maxV = getMaxConsecutive(vBars);

        int side = Math.min(maxH, maxV) + 1;
        return side * side;
    }

    private int getMaxConsecutive(int[] bars) {
        if (bars.length == 0) return 0;
        int max = 1;
        int current = 1;
        for (int i = 1; i < bars.length; i++) {
            if (bars[i] == bars[i - 1] + 1) {
                current++;
                max = Math.max(max, current);
            } else {
                current = 1;
            }
        }
        return max;
    }
}