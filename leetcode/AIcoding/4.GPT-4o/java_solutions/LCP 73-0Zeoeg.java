class Solution {
    public int maximumGold(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int[][] dp = new int[rows][cols];
        int maxGold = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] > 0) {
                    dp[i][j] = grid[i][j];
                    if (i > 0) dp[i][j] = Math.max(dp[i][j], grid[i][j] + dp[i - 1][j]);
                    if (j > 0) dp[i][j] = Math.max(dp[i][j], grid[i][j] + dp[i][j - 1]);
                    maxGold = Math.max(maxGold, dp[i][j]);
                }
            }
        }

        return maxGold;
    }
}