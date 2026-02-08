impl Solution {
    pub fn minimum_coins(prices: Vec<i32>) -> i64 {
        let n = prices.len();

        // dp[i] will store the minimum cost to buy fruits from index i to n-1.
        // We need n+2 size for dp[n] and dp[n+1] base cases.
        // dp[n] = 0 (cost to buy fruits from n to n-1, i.e., an empty set of fruits)
        // dp[n+1] = 0 (cost to buy fruits from n+1 to n-1, also an empty set)
        // These base cases handle array out-of-bounds for i+1 and i+2 when i is near n-1.
        let mut dp = vec![0; n + 2];

        // Iterate backwards from n-1 down to 0.
        for i in (0..n).rev() {
            // When considering fruit i, we must buy it (as it's not made free by i-1 for this subproblem).
            // We have two options regarding fruit i+1:

            // Option 1: Buy fruit i, and choose *not* to use the offer to get fruit i+1 for free.
            // In this case, fruit i+1 must be bought by the subproblem starting at i+1.
            // Cost = prices[i] + dp[i+1]
            let cost_buy_i_and_next = prices[i] as i64 + dp[i + 1];

            // Option 2: Buy fruit i, and *do* use the offer to get fruit i+1 for free.
            // In this case, fruit i+1 is covered, and we need to solve the subproblem starting at i+2.
            // Cost = prices[i] + dp[i+2]
            let cost_buy_i_get_next_free = prices[i] as i64 + dp[i + 2];

            // The minimum cost for dp[i] is the minimum of these two options.
            dp[i] = cost_buy_i_and_next.min(cost_buy_i_get_next_free);
        }

        // The result is the minimum cost to buy all fruits from index 0 to n-1.
        dp[0]
    }
}