public class Solution {
    public int maxProfit(int[] prices) {
        if (prices == null || prices.length == 0) return 0;
        int n = prices.length;
        int[][] dp = new int[n][5];

        for (int i = 0; i < n; i++) {
            dp[i][0] = (i == 0) ? 0 : dp[i - 1][0];
            dp[i][1] = (i == 0) ? -prices[i] : Math.max(dp[i - 1][1], dp[i - 1][0] - prices[i]);
            dp[i][2] = (i == 0) ? 0 : Math.max(dp[i - 1][2], dp[i - 1][1] + prices[i]);
            dp[i][3] = (i == 0) ? -prices[i] : Math.max(dp[i - 1][3], dp[i - 1][2] - prices[i]);
            dp[i][4] = (i == 0) ? 0 : Math.max(dp[i - 1][4], dp[i - 1][3] + prices[i]);
        }

        return dp[n - 1][4];
    }
}