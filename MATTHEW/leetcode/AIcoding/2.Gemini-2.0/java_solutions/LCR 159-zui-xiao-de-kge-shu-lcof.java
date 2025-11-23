import java.util.Arrays;

class Solution {
    public int maxProfit(int k, int[] prices) {
        int n = prices.length;
        if (n == 0) {
            return 0;
        }

        if (k >= n / 2) {
            int profit = 0;
            for (int i = 1; i < n; i++) {
                if (prices[i] > prices[i - 1]) {
                    profit += prices[i] - prices[i - 1];
                }
            }
            return profit;
        }

        int[][] dp = new int[k + 1][2];
        for (int i = 0; i <= k; i++) {
            dp[i][1] = Integer.MIN_VALUE;
        }

        for (int price : prices) {
            for (int i = k; i > 0; i--) {
                dp[i][1] = Math.max(dp[i][1], dp[i - 1][0] - price);
                dp[i][0] = Math.max(dp[i][0], dp[i][1] + price);
            }
        }

        return dp[k][0];
    }
}