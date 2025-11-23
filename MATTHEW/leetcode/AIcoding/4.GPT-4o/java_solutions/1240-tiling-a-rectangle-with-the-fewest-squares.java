class Solution {
    public int tilingRectangle(int n, int m) {
        int[][] dp = new int[n + 1][m + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= m; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                dp[i][j] = Math.min(dp[i][j], 1 + dp[i - 1][j]);
                dp[i][j] = Math.min(dp[i][j], 1 + dp[i][j - 1]);
                for (int k = 1; k <= Math.min(i, j); k++) {
                    dp[i][j] = Math.min(dp[i][j], 1 + dp[i - k][j - k]);
                }
            }
        }

        return dp[n][m];
    }
}