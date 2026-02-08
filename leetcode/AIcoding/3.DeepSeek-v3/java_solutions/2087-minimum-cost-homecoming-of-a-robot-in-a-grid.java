class Solution {
    public int minCost(int[] startPos, int[] homePos, int[] rowCosts, int[] colCosts) {
        int totalCost = 0;
        int x1 = startPos[0], y1 = startPos[1];
        int x2 = homePos[0], y2 = homePos[1];

        if (x1 < x2) {
            for (int i = x1 + 1; i <= x2; i++) {
                totalCost += rowCosts[i];
            }
        } else if (x1 > x2) {
            for (int i = x1 - 1; i >= x2; i--) {
                totalCost += rowCosts[i];
            }
        }

        if (y1 < y2) {
            for (int i = y1 + 1; i <= y2; i++) {
                totalCost += colCosts[i];
            }
        } else if (y1 > y2) {
            for (int i = y1 - 1; i >= y2; i--) {
                totalCost += colCosts[i];
            }
        }

        return totalCost;
    }
}