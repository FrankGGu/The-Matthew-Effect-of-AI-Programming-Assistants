impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let n = prices.len();

        // Initialize states for day 0
        // prev_hold: Max profit if we hold a stock on day 0 (bought it)
        // prev_sold: Max profit if we just sold a stock on day 0 (impossible, so set to a very small number)
        // prev_rest: Max profit if we are resting on day 0 (no action, profit is 0)
        let mut prev_hold = -prices[0];
        let mut prev_sold = i32::MIN; // Represents an invalid or impossible state
        let mut prev_rest = 0;

        // Iterate from day 1 to n-1
        for i in 1..n {
            let current_price = prices[i];

            // Calculate current_hold:
            // 1. Keep holding the stock from yesterday (prev_hold)
            // 2. Buy a stock today (must have been resting yesterday: prev_rest - current_price)
            let current_hold = prev_hold.max(prev_rest - current_price);

            // Calculate current_sold:
            // 1. Sell the stock today (must have been holding yesterday: prev_hold + current_price)
            let current_sold = prev_hold + current_price;

            // Calculate current_rest:
            // 1. Stay resting from yesterday (prev_rest)
            // 2. Transition from sold state yesterday (cooldown period: prev_sold)
            let current_rest = prev_rest.max(prev_sold);

            // Update previous states for the next iteration
            prev_hold = current_hold;
            prev_sold = current_sold;
            prev_rest = current_rest;
        }

        // The maximum profit can be either from selling on the last day (prev_sold),
        // or resting on the last day (prev_rest). It cannot be from holding a stock.
        prev_sold.max(prev_rest)
    }
}