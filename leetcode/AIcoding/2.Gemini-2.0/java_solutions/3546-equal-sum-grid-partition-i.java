class Solution {
    public int equalSumPartition(int[][] grid) {
        int n = grid.length;
        int[][] prefixSumRows = new int[n][n];
        int[][] prefixSumCols = new int[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                prefixSumRows[i][j] = grid[i][j];
                if (j > 0) {
                    prefixSumRows[i][j] += prefixSumRows[i][j - 1];
                }

                prefixSumCols[i][j] = grid[i][j];
                if (i > 0) {
                    prefixSumCols[i][j] += prefixSumCols[i - 1][j];
                }
            }
        }

        for (int row = 0; row < n - 1; row++) {
            for (int col = 0; col < n - 1; col++) {
                int sum1 = prefixSumRows[row][col] + prefixSumCols[row][col] - grid[row][col];
                int sum2 = prefixSumRows[row][n - 1] - prefixSumRows[row][col];
                int sum3 = prefixSumCols[n - 1][col] - prefixSumCols[row][col];
                int sum4 = prefixSumRows[n - 1][n - 1] - prefixSumRows[n - 1][col] - prefixSumCols[row][n - 1] + prefixSumRows[row][col];
                if (sum1 == sum2 && sum1 == sum3 && sum1 == sum4) {
                    return 1;
                }
            }
        }

        return 0;
    }
}