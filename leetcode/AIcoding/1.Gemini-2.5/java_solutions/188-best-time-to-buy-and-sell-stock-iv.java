class Solution {
    public int maxProfit(int k, int[] prices) {
        int n = prices.length;

        if (n == 0 || k == 0) {
            return 0;
        }

        // If k is very large, it means we can make as many transactions as possible.
        // The maximum number of useful transactions is n/2 (buy on day i, sell on day i+1).
        // If k >= n/2, this problem becomes "Best Time to Buy and Sell Stock II".
        if (k >= n / 2) {
            int maxProfit = 0;
            for (int i = 1; i < n; i++) {
                if (prices[i] > prices[i - 1]) {
                    maxProfit += prices[i] - prices[i - 1];
                }
            }
            return maxProfit;
        }

        // DP approach for limited transactions
        // buy[t] represents the maximum profit after t transactions, currently holding a stock (bought)
        // sell[t] represents the maximum profit after t transactions, currently not holding a stock (sold)

        int[] buy = new int[k + 1];
        int[] sell = new int[k + 1];

        // Initialize buy array with a very small number, representing negative profit if we buy first
        // Initialize sell array with 0, as 0 profit is possible with 0 transactions
        for (int i = 0; i <= k; i++) {
            buy[i] = Integer.MIN_VALUE; 
            sell[i] = 0;
        }

        for (int price : prices) {
            for (int t = 1; t <= k; t++) {
                // To calculate buy[t]:
                // Option 1: Don't buy today, keep previous buy state (buy[t] from previous day's price)
                // Option 2: Buy today. To do this, we must have completed t-1 sells previously (sell[t-1] from previous day's price)
                // and then buy the current stock (subtract current price).
                buy[t] = Math.max(buy[t], sell[t - 1] - price);

                // To calculate sell[t]:
                // Option 1: Don't sell today, keep previous sell state (sell[t] from previous day's price)
                // Option 2: Sell today. To do this, we must have bought the t-th stock previously or today (buy[t] from current day's price)
                // and then sell the current stock (add current price).
                sell[t] = Math.max(sell[t], buy[t] + price);
            }
        }

        return sell[k];
    }
}