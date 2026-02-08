class Solution {
    public long maxScore(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        long[][] dp = new long[m][n];
        long maxScore = Long.MIN_VALUE;

        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                dp[i][j] = Long.MIN_VALUE;
                if (i == m - 1 && j == n - 1) {
                    dp[i][j] = grid[i][j];
                    continue;
                }
                if (i + 1 < m) {
                    dp[i][j] = Math.max(dp[i][j], grid[i][j] - dp[i + 1][j]);
                }
                if (j + 1 < n) {
                    dp[i][j] = Math.max(dp[i][j], grid[i][j] - dp[i][j + 1]);
                }
                if (dp[i][j] == Long.MIN_VALUE) {
                    dp[i][j] = grid[i][j];
                }
                if (i != 0 || j != 0) {
                    maxScore = Math.max(maxScore, dp[i][j]);
                }
            }
        }
        return maxScore;
    }
}