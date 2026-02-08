class Solution {
    public int minCost(int[] startPos, int[] homePos, int[] rowCosts, int[] colCosts) {
        int rowStart = startPos[0];
        int colStart = startPos[1];
        int rowEnd = homePos[0];
        int colEnd = homePos[1];

        int rowCost = 0;
        if (rowStart < rowEnd) {
            for (int i = rowStart + 1; i <= rowEnd; i++) {
                rowCost += rowCosts[i];
            }
        } else if (rowStart > rowEnd) {
            for (int i = rowStart - 1; i >= rowEnd; i--) {
                rowCost += rowCosts[i];
            }
        }

        int colCost = 0;
        if (colStart < colEnd) {
            for (int i = colStart + 1; i <= colEnd; i++) {
                colCost += colCosts[i];
            }
        } else if (colStart > colEnd) {
            for (int i = colStart - 1; i >= colEnd; i--) {
                colCost += colCosts[i];
            }
        }

        return rowCost + colCost;
    }
}