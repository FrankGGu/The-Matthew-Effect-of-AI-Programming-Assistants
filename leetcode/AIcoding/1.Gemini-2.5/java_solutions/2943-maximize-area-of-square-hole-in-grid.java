import java.util.Arrays;

class Solution {
    public int maximizeSquareHoleArea(int n, int m, int[] hBars, int[] vBars) {
        int maxHoleSideH = calculateMaxConsecutiveCells(hBars);
        int maxHoleSideV = calculateMaxConsecutiveCells(vBars);

        int side = Math.min(maxHoleSideH, maxHoleSideV);
        return side * side;
    }

    private int calculateMaxConsecutiveCells(int[] bars) {
        if (bars.length == 0) {
            return 1;
        }

        Arrays.sort(bars);

        int maxConsecutiveRemoved = 1;
        int currentConsecutiveRemoved = 1;

        for (int i = 1; i < bars.length; i++) {
            if (bars[i] == bars[i-1] + 1) {
                currentConsecutiveRemoved++;
            } else {
                currentConsecutiveRemoved = 1;
            }
            maxConsecutiveRemoved = Math.max(maxConsecutiveRemoved, currentConsecutiveRemoved);
        }

        return maxConsecutiveRemoved + 1;
    }
}