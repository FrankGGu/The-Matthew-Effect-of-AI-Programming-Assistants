impl Solution {
    pub fn max_profit(k: i32, prices: Vec<i32>) -> i32 {
        let n = prices.len();

        // If prices array is empty or has only one element, no profit can be made.
        // This is implicitly handled by the subsequent logic, but explicit check is fine.
        // Based on constraints, n >= 1.
        if n == 0 {
            return 0;
        }

        // If k is large enough, it's equivalent to "Best Time to Buy and Sell Stock II"
        // where you can make as many transactions as you want.
        // A transaction requires at least 2 days (buy and sell).
        // So, the maximum number of transactions possible is n / 2.
        // If k is greater than or equal to n / 2, we can effectively make unlimited transactions.
        if k as usize >= n / 2 {
            let mut max_profit = 0;
            for i in 1..n {
                if prices[i] > prices[i - 1] {
                    max_profit += prices[i] - prices[i - 1];
                }
            }
            return max_profit;
        }

        // DP approach for limited k transactions
        // dp_buy[t] represents the maximum profit after 't' buy operations (and 't-1' sell operations),
        // currently holding a stock.
        // dp_sell[t] represents the maximum profit after 't' buy operations and 't' sell operations,
        // currently not holding a stock.

        // Initialize dp_buy with a very small number to represent an impossible state
        // or a state with very high loss. Using i32::MIN / 2 to prevent overflow
        // when adding a price (max price is 1000).
        let mut dp_buy = vec![i32::MIN / 2; k as usize + 1];
        // Initialize dp_sell with 0, as no transactions means 0 profit.
        let mut dp_sell = vec![0; k as usize + 1];

        for price in prices {
            // Iterate transactions from k down to 1.
            // This ensures that when we calculate dp_buy[t] using dp_sell[t-1],
            // dp_sell[t-1] refers to the state *before* considering the current price.
            for t in (1..=k as usize).rev() {
                // Update dp_sell[t]:
                // Option 1: Do nothing, keep the maximum profit from previous day with 't' sells.
                // Option 2: Sell the stock bought in the 't'-th transaction.
                //           Profit will be (profit from 't' buys, currently holding stock) + current price.
                dp_sell[t] = dp_sell[t].max(dp_buy[t] + price);

                // Update dp_buy[t]:
                // Option 1: Do nothing, keep the maximum profit from previous day with 't' buys.
                // Option 2: Buy the stock for the 't'-th transaction.
                //           Profit will be (profit from 't-1' sells, not holding stock) - current price.
                dp_buy[t] = dp_buy[t].max(dp_sell[t - 1] - price);
            }
        }

        // The maximum profit will be dp_sell[k] after iterating through all prices.
        // dp_sell[k] represents the max profit after at most k transactions (k buys and k sells).
        dp_sell[k as usize]
    }
}