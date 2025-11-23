class Solution {
    public long sellingWood(int m, int n, int[][] prices) {
        long[][] dp = new long[m + 1][n + 1];

        for (int[] price : prices) {
            int h = price[0];
            int w = price[1];
            long p = price[2];
            if (h <= m && w <= n) {
                dp[h][w] = Math.max(dp[h][w], p);
            }
        }

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                // Option 1: Cut horizontally
                for (int k = 1; k < i; k++) {
                    dp[i][j] = Math.max(dp[i][j], dp[k][j] + dp[i - k][j]);
                }

                // Option 2: Cut vertically
                for (int k = 1; k < j; k++) {
                    dp[i][j] = Math.max(dp[i][j], dp[i][k] + dp[i][j - k]);
                }
            }
        }

        return dp[m][n];
    }
}