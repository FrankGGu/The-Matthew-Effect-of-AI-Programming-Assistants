class Solution {
    public int maxProfit(int[] prices) {
        int n = prices.length;
        if (n == 0) return 0;

        int[] buy = new int[n];
        int[] sell = new int[n];

        buy[0] = -prices[0];
        sell[0] = 0;

        for (int i = 1; i < n; i++) {
            buy[i] = Math.max(buy[i - 1], sell[i - 1] - prices[i]);
            sell[i] = Math.max(sell[i - 1], buy[i - 1] + prices[i]);
            if (i > 1) {
                sell[i] = Math.max(sell[i], buy[i - 2] + prices[i]);
            }
        }

        return sell[n - 1];
    }
}