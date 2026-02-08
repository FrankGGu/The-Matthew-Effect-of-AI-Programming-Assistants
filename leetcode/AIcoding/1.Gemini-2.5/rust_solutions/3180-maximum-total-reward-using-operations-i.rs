impl Solution {
    pub fn max_total_reward(mut reward: Vec<i32>) -> i32 {
        // Sort rewards in ascending order. This is crucial for the DP approach
        // because it ensures that when we consider adding a reward `r`,
        // we have already processed all smaller rewards, allowing `s` to grow.
        reward.sort_unstable();

        // dp[s] will be true if sum 's' is achievable.
        // The maximum possible sum is N * max_reward_value = 2000 * 1000 = 2,000,000.
        // We use a Vec<bool> for the DP table.
        let max_possible_sum = 2000 * 1000;
        let mut dp = vec![false; max_possible_sum + 1];

        // Initial state: sum 0 is achievable (by taking no rewards).
        dp[0] = true;

        // max_current_sum_reachable tracks the highest sum 's' for which dp[s] is true.
        // This helps to optimize the inner loop range.
        let mut max_current_sum_reachable = 0;

        for r in reward {
            // Iterate 's' downwards to avoid using the same 'r' multiple times within a single iteration.
            // For example, if we iterate upwards, `dp[s]` might be true, we set `dp[s+r]=true`.
            // Then, if `s+r < r'` (for some later r'), we might use `s+r` to form `s+r+r'`.
            // But if `s+r` was just formed using the current `r`, this would be incorrect.
            // Iterating downwards ensures that when we consider `dp[s]`, `s` was formed
            // using rewards *before* the current `r`.

            // The condition `s < r` means we only care about `s` values that are strictly less than `r`.
            // So, the inner loop only needs to consider `s` up to `r-1`.
            // The actual upper bound for `s` is `min(max_current_sum_reachable, r - 1)`.
            // However, iterating from `max_current_sum_reachable` down to `0` and checking `s < r` inside
            // the loop is functionally equivalent and often simpler to implement correctly.
            // The `s < r` check effectively prunes the iterations.
            for s in (0..=max_current_sum_reachable).rev() {
                if dp[s] && s < r {
                    // If sum 's' is achievable and 's < r', then 's + r' is also achievable.
                    dp[s + r] = true;

                    // Update the maximum reachable sum if a new higher sum is found.
                    // This optimization is key for the overall time complexity.
                    if s + r > max_current_sum_reachable {
                        max_current_sum_reachable = s + r;
                    }
                }
            }
        }

        // The final answer is the maximum sum 's' for which dp[s] is true.
        // This value is stored in `max_current_sum_reachable`.
        max_current_sum_reachable
    }
}