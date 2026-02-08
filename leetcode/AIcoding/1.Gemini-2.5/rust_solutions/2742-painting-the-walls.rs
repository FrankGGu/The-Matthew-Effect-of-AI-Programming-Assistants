impl Solution {
    pub fn paint_walls(cost: Vec<i32>, time: Vec<i32>) -> i32 {
        let n = cost.len();

        // dp[j] will store the minimum cost to achieve a "net capacity" of 'j'.
        // The "net capacity" for choosing a wall 'i' for the paid painter is (1 + time[i]).
        // This represents 1 wall painted by the paid painter and time[i] walls painted by the free painter.
        // So, 'j' is the sum of (1 + time[k]) for all walls 'k' chosen for the paid painter.
        // We need this sum to be at least 'n' to ensure all 'n' walls are painted.

        // Calculate the maximum possible "net capacity" 'j'.
        // If all 'n' walls are chosen for the paid painter, and each time[i] is at its maximum (500),
        // then j = sum(1 + time[i]) = n * 1 + sum(time[i]) <= n + n * 500.
        // For n=500, max_time=500: max_j = 500 + 500 * 500 = 250500.
        // This upper bound for 'j' fits within typical memory limits for DP arrays.
        let max_capacity = n + n * 500; 

        // Initialize dp array with a large value representing infinity.
        // dp[0] is 0 because 0 cost is needed to achieve 0 net capacity.
        let mut dp = vec![std::i32::MAX; max_capacity + 1];
        dp[0] = 0; 

        // Iterate through each wall (item)
        for i in 0..n {
            let current_cost = cost[i];
            // The "weight" or "effective capacity" for this wall is 1 (for the paid wall itself) + time[i] (for free walls).
            let effective_capacity = time[i] + 1; 

            // Iterate backwards through the dp array to simulate 0/1 knapsack behavior.
            // This ensures that each wall is considered at most once for the current 'j' calculation.
            for j in (effective_capacity as usize..=max_capacity).rev() {
                // If dp[j - effective_capacity] is not infinity, it means we can reach that state.
                if dp[j - effective_capacity as usize] != std::i32::MAX {
                    dp[j] = dp[j].min(dp[j - effective_capacity as usize] + current_cost);
                }
            }
        }

        // After processing all walls, the answer is the minimum cost for any 'j'
        // such that 'j' (total effective capacity) is at least 'n'.
        // This is because 'j' represents (number of paid walls + total time spent by paid painter),
        // and we need this sum to be >= n to ensure all walls are covered.
        let mut min_total_cost = std::i32::MAX;
        for j in n..=max_capacity {
            min_total_cost = min_total_cost.min(dp[j]);
        }

        min_total_cost
    }
}