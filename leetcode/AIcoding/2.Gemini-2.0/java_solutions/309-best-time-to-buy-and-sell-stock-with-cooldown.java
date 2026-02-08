class Solution {
    public int maxProfit(int[] prices) {
        if (prices == null || prices.length <= 1) {
            return 0;
        }

        int n = prices.length;
        int[] buy = new int[n];
        int[] sell = new int[n];
        int[] cooldown = new int[n];

        buy[0] = -prices[0];
        sell[0] = 0;
        cooldown[0] = 0;

        for (int i = 1; i < n; i++) {
            buy[i] = Math.max(buy[i - 1], cooldown[i - 1] - prices[i]);
            sell[i] = buy[i - 1] + prices[i];
            cooldown[i] = Math.max(cooldown[i - 1], Math.max(sell[i - 1], buy[i-1]));
        }

        return Math.max(sell[n - 1], cooldown[n - 1]);
    }
}