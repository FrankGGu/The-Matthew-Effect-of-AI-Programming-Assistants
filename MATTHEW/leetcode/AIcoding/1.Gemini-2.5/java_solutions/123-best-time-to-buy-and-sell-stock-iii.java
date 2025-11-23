class Solution {
    public int maxProfit(int[] prices) {
        if (prices == null || prices.length == 0) {
            return 0;
        }

        // buy1: maximum profit if we finish the first buy
        // sell1: maximum profit if we finish the first sell
        // buy2: maximum profit if we finish the second buy
        // sell2: maximum profit if we finish the second sell

        // Initialize buy states to a very small number (negative infinity)
        // to ensure any actual buy operation will result in a larger (less negative) profit.
        // Initialize sell states to 0 as no profit has been made yet.
        int buy1 = Integer.MIN_VALUE;
        int sell1 = 0;
        int buy2 = Integer.MIN_VALUE;
        int sell2 = 0;

        for (int price : prices) {
            // sell2: The maximum profit after completing the second sell.
            // It's either the previous max sell2, or the profit from buying for the second time (buy2)
            // and then selling at the current price.
            sell2 = Math.max(sell2, buy2 + price);

            // buy2: The maximum profit after completing the second buy.
            // It's either the previous max buy2, or the profit from selling for the first time (sell1)
            // and then buying at the current price (reducing profit).
            buy2 = Math.max(buy2, sell1 - price);

            // sell1: The maximum profit after completing the first sell.
            // It's either the previous max sell1, or the profit from buying for the first time (buy1)
            // and then selling at the current price.
            sell1 = Math.max(sell1, buy1 + price);

            // buy1: The maximum profit after completing the first buy.
            // It's either the previous max buy1, or simply buying at the current price (negative profit).
            buy1 = Math.max(buy1, -price);
        }

        // The maximum profit after at most two transactions will be the maximum profit after the second sell.
        return sell2;
    }
}