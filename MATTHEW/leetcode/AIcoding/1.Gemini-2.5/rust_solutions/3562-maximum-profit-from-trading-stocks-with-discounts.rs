impl Solution {
    pub fn max_profit(prices: Vec<i32>, discount: i32) -> i32 {
        if prices.is_empty() {
            return 0;
        }

        // `hold`: maximum profit if we currently hold a stock.
        // This value represents the profit accumulated up to the point of buying,
        // effectively the negative cost of the stock if we consider all previous transactions.
        // A higher `hold` value means we acquired the stock more cheaply (or even got paid to take it).
        let mut hold = -prices[0] + discount;

        // `cash`: maximum profit if we currently do not hold a stock.
        // This value represents the total profit accumulated from all completed buy-sell transactions.
        let mut cash = 0;

        for i in 1..prices.len() {
            // Option 1: Update `hold` state
            // We can either:
            // a) Keep holding the stock we already have (profit remains `hold`).
            // b) Buy a new stock today. To do this, we must have been in the `cash` state yesterday.
            //    The cost of buying is `prices[i]`, but we get a `discount`.
            //    So, the profit from buying today is `cash - prices[i] + discount`.
            let new_hold = hold.max(cash - prices[i] + discount);

            // Option 2: Update `cash` state
            // We can either:
            // a) Keep not holding a stock (profit remains `cash`).
            // b) Sell the stock we were holding yesterday.
            //    The profit from selling today is `hold + prices[i]`.
            let new_cash = cash.max(hold + prices[i]);

            hold = new_hold;
            cash = new_cash;
        }

        // The maximum profit will always be in the `cash` state, as we want to end up
        // without holding any stock to realize the profit.
        cash
    }
}