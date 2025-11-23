class Solution {
    public int maxMoves(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dp = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dp[i], 1);
        }
        for (int j = 0; j < n; j++) {
            for (int i = 0; i < m; i++) {
                if (j > 0 && i > 0 && grid[i][j] > grid[i - 1][j - 1]) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - 1] + 1);
                }
                if (j > 0 && i < m - 1 && grid[i][j] > grid[i + 1][j - 1]) {
                    dp[i][j] = Math.max(dp[i][j], dp[i + 1][j - 1] + 1);
                }
                if (j > 0 && grid[i][j] > grid[i][j - 1]) {
                    dp[i][j] = Math.max(dp[i][j], dp[i][j - 1] + 1);
                }
            }
        }
        int maxMoves = 0;
        for (int i = 0; i < m; i++) {
            maxMoves = Math.max(maxMoves, dp[i][n - 1]);
        }
        return maxMoves;
    }
}