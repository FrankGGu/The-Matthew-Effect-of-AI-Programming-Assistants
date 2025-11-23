impl Solution {
    pub fn tallest_billboard(rods: Vec<i32>) -> i32 {
        let total_sum: i32 = rods.iter().sum();
        let offset = total_sum as usize;
        // dp[offset + diff] stores the maximum sum of rods on the left pole,
        // such that sum_left - sum_right = diff.
        // Initialize with -1 to indicate unreachable states.
        // dp[offset] = 0 means sum_left = 0, sum_right = 0, diff = 0.
        let mut dp = vec![-1; 2 * total_sum as usize + 1];
        dp[offset] = 0;

        for &rod in rods.iter() {
            let mut next_dp = dp.clone(); // Create a copy for the next iteration's DP states

            // Iterate through all possible differences
            for diff_val in -total_sum..=total_sum {
                let current_sum_left = dp[offset + diff_val as usize];

                // If this state is unreachable, skip
                if current_sum_left == -1 {
                    continue;
                }

                // Option 1: Add the current rod to the left pole
                let new_diff_left = diff_val + rod;
                let new_sum_left_left = current_sum_left + rod;
                next_dp[offset + new_diff_left as usize] =
                    next_dp[offset + new_diff_left as usize].max(new_sum_left_left);

                // Option 2: Add the current rod to the right pole
                let new_diff_right = diff_val - rod;
                let new_sum_left_right = current_sum_left; // sum_left doesn't change
                next_dp[offset + new_diff_right as usize] =
                    next_dp[offset + new_diff_right as usize].max(new_sum_left_right);

                // Option 3: Do not use the current rod (implicitly handled by next_dp = dp.clone())
            }
            dp = next_dp; // Update dp for the next rod
        }

        // The problem asks for the maximum total length of rods used such that
        // the lengths on both supports are equal.
        // If sum_left = sum_right = X, then total length is 2 * X.
        // dp[offset] stores the maximum X when sum_left - sum_right = 0.
        dp[offset]
    }
}