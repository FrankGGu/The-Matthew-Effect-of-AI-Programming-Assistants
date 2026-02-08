impl Solution {
    pub fn maximum_multiplication_score(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = multipliers.len();

        // dp[j] represents the maximum score after 'i' operations, having taken 'j' elements from the left.
        // The number of operations 'i' is implicit in the outer loop.
        // We use a 1D DP array to optimize space. dp[j] stores dp[i-1][j].
        // new_dp[j] will store dp[i][j].
        let mut dp: Vec<i64> = vec![std::i64::MIN; m + 1];

        // Base case: 0 operations, 0 elements taken from left, score is 0.
        dp[0] = 0;

        for i in 1..=m { // i represents the current operation count (1 to m)
            // The current multiplier is multipliers[i-1]
            let current_multiplier = multipliers[i-1] as i64;

            // Create a new DP array for the current operation 'i'
            let mut new_dp: Vec<i64> = vec![std::i64::MIN; m + 1];

            // Iterate 'j' (number of elements taken from left) from 'i' down to '0'.
            // Iterating downwards is crucial if updating in-place, but good practice here too.
            // j cannot exceed i (number of left elements cannot exceed total operations).
            for j in (0..=i).rev() { 
                let mut val_from_left = std::i64::MIN;
                let mut val_from_right = std::i64::MIN;

                // Option 1: Take an element from the left side of nums.
                // This means 'j-1' elements were taken from left in the previous 'i-1' operations.
                // The element taken now is nums[j-1].
                if j > 0 && dp[j-1] != std::i64::MIN { 
                    val_from_left = dp[j-1] + nums[j-1] as i64 * current_multiplier;
                }

                // Option 2: Take an element from the right side of nums.
                // This means 'j' elements were taken from left in the previous 'i-1' operations.
                // The number of elements taken from the right is (i-j).
                // The index of the element taken from the right is n - (i - j).
                // This option is valid only if we haven't taken all 'i' elements from the left (i.e., j < i).
                if j < i && dp[j] != std::i64::MIN { 
                    let right_idx = n - (i - j);
                    // The right_idx will always be valid (>=0) because m <= n and i <= m.
                    // So n - (i - j) >= n - (i) >= n - m >= 0.
                    val_from_right = dp[j] + nums[right_idx] as i64 * current_multiplier;
                }

                new_dp[j] = val_from_left.max(val_from_right);
            }
            dp = new_dp;
        }

        // The maximum score will be the maximum value in the final dp array.
        // This corresponds to dp[m][j] for all possible j from 0 to m.
        dp.into_iter().max().unwrap_or(0) as i32
    }
}