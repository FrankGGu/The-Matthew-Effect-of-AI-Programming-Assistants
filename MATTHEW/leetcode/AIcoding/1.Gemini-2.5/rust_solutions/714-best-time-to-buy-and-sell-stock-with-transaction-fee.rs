impl Solution {
    pub fn max_profit(prices: Vec<i32>, fee: i32) -> i32 {
        if prices.is_empty() {
            return 0;
        }

        let mut hold = -prices[0]; // Maximum profit if we hold a stock
        let mut free = 0;         // Maximum profit if we don't hold a stock

        for i in 1..prices.len() {
            let prev_hold = hold;

            // Option 1: Continue holding the stock from yesterday.
            // Option 2: Buy a stock today (must have been free yesterday).
            hold = hold.max(free - prices[i]);

            // Option 1: Continue being free from yesterday.
            // Option 2: Sell the stock today (must have held it yesterday).
            free = free.max(prev_hold + prices[i] - fee);
        }

        free
    }
}