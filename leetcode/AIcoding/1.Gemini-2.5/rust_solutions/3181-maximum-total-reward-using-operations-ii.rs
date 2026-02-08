impl Solution {
    pub fn max_total_reward(mut reward_values: Vec<i32>) -> i32 {
        // Sort the reward values in ascending order.
        // Remove duplicate values. The problem is typically interpreted such that
        // each unique reward value can be used at most once to form a sum.
        reward_values.sort_unstable();
        reward_values.dedup();

        // Determine the maximum value among the unique rewards.
        // This is used to size the dynamic programming array.
        // The maximum possible total reward is bounded by `2 * max(rewardValues) - 1`.
        // If `max_val` is 1000, the maximum reward is 1999.
        let max_val = *reward_values.last().unwrap_or(&0);

        // Handle edge case where reward_values is empty or contains only 0s.
        if max_val == 0 {
            return 0;
        }

        // `dp[i]` will be true if a total reward of `i` can be achieved.
        // The array size needs to accommodate up to `2 * max_val - 1`.
        // We use `2 * max_val` as the upper bound for the array size to ensure all
        // possible sums up to `2 * max_val - 1` are covered by valid indices.
        let max_possible_sum_bound = 2 * max_val;
        let mut dp = vec![false; max_possible_sum_bound as usize];

        // A reward of 0 is always achievable (by choosing no rewards).
        dp[0] = true;

        // Iterate through each unique reward value `x`.
        for &x in reward_values.iter() {
            // For each `x`, we can potentially add it to existing achievable sums `s`.
            // The condition is that `x` must be strictly greater than `s` (`s < x`).
            // We iterate `s` downwards from `x - 1` to `0`. This ensures that when we
            // set `dp[s + x] = true`, the `dp[s]` value used is from the state *before*
            // considering the current `x`.
            // The maximum value `s` can take is `x - 1`.
            // The maximum sum `s + x` can become is `(x - 1) + x = 2x - 1`.
            // Since `x <= max_val`, `2x - 1 <= 2 * max_val - 1`, which is within our `dp` array bounds.
            for s in (0..x).rev() {
                if dp[s as usize] {
                    dp[(s + x) as usize] = true;
                }
            }
        }

        // After processing all reward values, find the largest `i` for which `dp[i]` is true.
        // This `i` represents the maximum possible total reward.
        for i in (0..max_possible_sum_bound).rev() {
            if dp[i as usize] {
                return i;
            }
        }

        // This line should theoretically not be reached because dp[0] is always true.
        0
    }
}