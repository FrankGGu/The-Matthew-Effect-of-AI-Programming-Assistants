class Solution {
    public int minimumCoins(int[] prices) {
        int n = prices.length;
        int[] dp = new int[n + 2];
        for (int i = n; i >= 1; i--) {
            dp[i] = Integer.MAX_VALUE;
            for (int j = i + 1; j <= Math.min(2 * i + 1, n); j++) {
                dp[i] = Math.min(dp[i], dp[j] + prices[i - 1]);
            }
            if (dp[i] == Integer.MAX_VALUE) {
                dp[i] = prices[i - 1];
            }
        }
        return dp[1];
    }
}