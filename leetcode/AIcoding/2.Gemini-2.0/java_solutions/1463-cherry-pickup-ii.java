class Solution {
    public int cherryPickup(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;

        int[][][] dp = new int[rows][cols][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                for (int k = 0; k < cols; k++) {
                    dp[i][j][k] = -1;
                }
            }
        }

        dp[0][0][cols - 1] = grid[0][0];
        if (0 != cols - 1) {
            dp[0][0][cols - 1] += grid[0][cols - 1];
        }

        for (int row = 1; row < rows; row++) {
            for (int col1 = 0; col1 < cols; col1++) {
                for (int col2 = 0; col2 < cols; col2++) {
                    for (int prevCol1 = Math.max(0, col1 - 1); prevCol1 <= Math.min(cols - 1, col1 + 1); prevCol1++) {
                        for (int prevCol2 = Math.max(0, col2 - 1); prevCol2 <= Math.min(cols - 1, col2 + 1); prevCol2++) {
                            if (dp[row - 1][prevCol1][prevCol2] != -1) {
                                int currentCherries = grid[row][col1];
                                if (col1 != col2) {
                                    currentCherries += grid[row][col2];
                                }
                                dp[row][col1][col2] = Math.max(dp[row][col1][col2], dp[row - 1][prevCol1][prevCol2] + currentCherries);
                            }
                        }
                    }
                }
            }
        }

        int maxCherries = 0;
        for (int i = 0; i < cols; i++) {
            for (int j = 0; j < cols; j++) {
                maxCherries = Math.max(maxCherries, dp[rows - 1][i][j]);
            }
        }

        return maxCherries;
    }
}