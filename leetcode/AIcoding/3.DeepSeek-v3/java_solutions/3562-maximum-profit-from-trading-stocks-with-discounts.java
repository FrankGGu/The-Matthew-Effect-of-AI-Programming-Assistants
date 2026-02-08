class Solution {
    public int maxProfit(int[] prices, int[] discounts) {
        int n = prices.length;
        int m = discounts.length;
        int[][] dp = new int[n + 1][m + 1];

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= m; j++) {
                dp[i][j] = dp[i - 1][j];
                if (j > 0) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - 1] + prices[i - 1] - discounts[j - 1]);
                }
            }
        }

        return dp[n][m];
    }
}