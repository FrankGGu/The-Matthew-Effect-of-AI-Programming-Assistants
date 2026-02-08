class Solution {
    public int minFlips(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        int[][][] dp = new int[n + 1][m + 1][2];

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= m; j++) {
                for (int k = 0; k < 2; k++) {
                    dp[i][j][k] = Integer.MAX_VALUE;
                }
            }
        }

        dp[0][0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                for (int k = 0; k < 2; k++) {
                    if (dp[i][j][k] == Integer.MAX_VALUE) continue;

                    int flips = 0;
                    if (grid[i][j] != k) flips++;

                    if (i + 1 < n) {
                        dp[i + 1][j][k] = Math.min(dp[i + 1][j][k], dp[i][j][k] + flips);
                    }
                    if (j + 1 < m) {
                        dp[i][j + 1][k] = Math.min(dp[i][j + 1][k], dp[i][j][k] + flips);
                    }
                    if (i + 1 < n && j + 1 < m) {
                        dp[i + 1][j + 1][k ^ 1] = Math.min(dp[i + 1][j + 1][k ^ 1], dp[i][j][k] + flips);
                    }
                }
            }
        }

        return dp[n][m][0] == Integer.MAX_VALUE ? -1 : dp[n][m][0];
    }
}