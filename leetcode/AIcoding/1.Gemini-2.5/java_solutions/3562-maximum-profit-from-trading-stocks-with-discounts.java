class Solution {
    public int maxProfit(int k, int[] prices, int[] discounts) {
        if (prices == null || prices.length == 0) {
            return 0;
        }

        int n = prices.length;

        if (k >= n / 2) {
            int buy = Integer.MIN_VALUE;
            int sell = 0;
            for (int i = 0; i < n; i++) {
                int currentPrice = prices[i];
                int currentDiscount = discounts[i];
                int prevBuy = buy;
                buy = Math.max(buy, sell - currentPrice + currentDiscount);
                sell = Math.max(sell, prevBuy + currentPrice);
            }
            return sell;
        }

        int[] buy = new int[k + 1];
        int[] sell = new int[k + 1];

        for (int j = 0; j <= k; j++) {
            buy[j] = Integer.MIN_VALUE;
            sell[j] = 0;
        }

        for (int i = 0; i < n; i++) {
            int currentPrice = prices[i];
            int currentDiscount = discounts[i];
            for (int j = k; j >= 1; j--) {
                sell[j] = Math.max(sell[j], buy[j] + currentPrice);
                buy[j] = Math.max(buy[j], sell[j-1] - currentPrice + currentDiscount);
            }
            buy[0] = Math.max(buy[0], sell[0] - currentPrice + currentDiscount);
        }

        int maxTotalProfit = 0;
        for (int j = 0; j <= k; j++) {
            maxTotalProfit = Math.max(maxTotalProfit, sell[j]);
        }
        return maxTotalProfit;
    }
}