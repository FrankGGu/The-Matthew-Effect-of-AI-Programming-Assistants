class Solution {
    public int maximumProfit(int[] prices, int fee, int discount) {
        int n = prices.length;
        int[] dp = new int[n];
        dp[0] = 0;
        int minPrice = prices[0];
        for (int i = 1; i < n; i++) {
            dp[i] = dp[i - 1];
            if (prices[i] > minPrice + fee) {
                dp[i] = Math.max(dp[i], dp[i - 1] + prices[i] - minPrice - fee);
            }
            minPrice = Math.min(minPrice, prices[i] - dp[i - 1] - discount);
        }
        return dp[n - 1];
    }
}