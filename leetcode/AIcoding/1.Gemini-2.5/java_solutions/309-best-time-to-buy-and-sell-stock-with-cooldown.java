class Solution {
    public int maxProfit(int[] prices) {
        if (prices == null || prices.length == 0) {
            return 0;
        }

        int n = prices.length;

        // s0_prev: maximum profit ending with no stock, and not in cooldown (can buy next day)
        // s1_prev: maximum profit ending with having a stock (bought today or earlier)
        // s2_prev: maximum profit ending with no stock, and in cooldown (cannot buy next day)

        // Initialize for day 0
        int s0_prev = 0; // No stock, no profit
        int s1_prev = -prices[0]; // Bought stock on day 0, so profit is negative of price
        int s2_prev = Integer.MIN_VALUE; // Cannot be in cooldown on day 0 if no stock was sold

        for (int i = 1; i < n; i++) {
            // Calculate current states based on previous day's states
            int s0_curr = Math.max(s0_prev, s2_prev); // Option 1: Stay in s0 (do nothing). Option 2: Transition from s2 (cooldown ends).
            int s1_curr = Math.max(s1_prev, s0_prev - prices[i]); // Option 1: Stay in s1 (hold stock). Option 2: Transition from s0 (buy stock today).
            int s2_curr = s1_prev + prices[i]; // Must transition from s1 (sell stock today).

            // Update previous states for the next iteration
            s0_prev = s0_curr;
            s1_prev = s1_curr;
            s2_prev = s2_curr;
        }

        // The maximum profit must be from a state where we don't hold any stock.
        // This can be either s0 (no stock, ready to buy) or s2 (no stock, in cooldown).
        return Math.max(s0_prev, s2_prev);
    }
}