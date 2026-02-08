class Solution {
    public int[][] restoreMatrix(int[] rowSum, int[] colSum) {
        int numRows = rowSum.length;
        int numCols = colSum.length;
        int[][] result = new int[numRows][numCols];

        for (int i = 0; i < numRows; i++) {
            for (int j = 0; j < numCols; j++) {
                int val = Math.min(rowSum[i], colSum[j]);
                result[i][j] = val;
                rowSum[i] -= val;
                colSum[j] -= val;
            }
        }
        return result;
    }
}