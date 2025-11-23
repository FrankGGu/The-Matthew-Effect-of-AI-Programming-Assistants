class Solution {
    public int maxMoves(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[m][n];
        int maxMoves = 0;

        for (int j = 0; j < n - 1; j++) {
            for (int i = 0; i < m; i++) {
                if (j == 0) {
                    dp[i][j] = 0;
                }

                if (grid[i][j] < grid[i][j + 1]) {
                    dp[i][j + 1] = Math.max(dp[i][j + 1], dp[i][j] + 1);
                    maxMoves = Math.max(maxMoves, dp[i][j + 1]);
                }

                if (i > 0 && grid[i][j] < grid[i - 1][j + 1]) {
                    dp[i - 1][j + 1] = Math.max(dp[i - 1][j + 1], dp[i][j] + 1);
                    maxMoves = Math.max(maxMoves, dp[i - 1][j + 1]);
                }

                if (i < m - 1 && grid[i][j] < grid[i + 1][j + 1]) {
                    dp[i + 1][j + 1] = Math.max(dp[i + 1][j + 1], dp[i][j] + 1);
                    maxMoves = Math.max(maxMoves, dp[i + 1][j + 1]);
                }
            }
        }

        return maxMoves;
    }
}