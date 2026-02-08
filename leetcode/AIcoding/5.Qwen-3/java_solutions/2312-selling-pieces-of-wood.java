public class Solution {
    public long sellingWood(int n, int m, int[][] prices) {
        long[][] dp = new long[n + 1][m + 1];

        for (int[] price : prices) {
            int x = price[0];
            int y = price[1];
            int val = price[2];
            dp[x][y] = val;
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                for (int k = 1; k < i; k++) {
                    dp[i][j] = Math.max(dp[i][j], dp[k][j] + dp[i - k][j]);
                }
                for (int l = 1; l < j; l++) {
                    dp[i][j] = Math.max(dp[i][j], dp[i][l] + dp[i][j - l]);
                }
            }
        }

        return dp[n][m];
    }
}