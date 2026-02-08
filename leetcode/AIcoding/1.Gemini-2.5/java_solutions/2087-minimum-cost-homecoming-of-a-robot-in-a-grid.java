class Solution {
    public int minCost(int[] startPos, int[] homePos, int[] rowCosts, int[] colCosts) {
        long totalCost = 0;

        int startRow = startPos[0];
        int startCol = startPos[1];
        int homeRow = homePos[0];
        int homeCol = homePos[1];

        // Calculate cost for row movements
        if (startRow < homeRow) {
            for (int r = startRow + 1; r <= homeRow; r++) {
                totalCost += rowCosts[r];
            }
        } else if (startRow > homeRow) {
            for (int r = startRow - 1; r >= homeRow; r--) {
                totalCost += rowCosts[r];
            }
        }

        // Calculate cost for column movements
        if (startCol < homeCol) {
            for (int c = startCol + 1; c <= homeCol; c++) {
                totalCost += colCosts[c];
            }
        } else if (startCol > homeCol) {
            for (int c = startCol - 1; c >= homeCol; c--) {
                totalCost += colCosts[c];
            }
        }

        return (int) totalCost;
    }
}