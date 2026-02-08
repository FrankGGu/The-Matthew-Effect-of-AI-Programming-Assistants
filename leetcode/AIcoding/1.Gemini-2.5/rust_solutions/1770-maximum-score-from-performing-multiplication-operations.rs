impl Solution {
    pub fn maximum_score(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = multipliers.len();

        // dp[j] stores the maximum score after 'i' operations,
        // having taken 'j' elements from the left side of `nums`.
        // We use a 1D array for space optimization.
        // At the start of iteration `i`, `dp[j]` represents `dp[i-1][j]`.
        // When updating for iteration `i`, we iterate `j` from `i` down to `0`.
        // This ensures that `dp[j-1]` (representing `dp[i-1][j-1]`)
        // and `dp[j]` (representing `dp[i-1][j]`) are still values from the previous iteration.
        let mut dp: Vec<i64> = vec![i64::MIN; m + 1];

        // Base case: 0 operations, 0 elements taken from left, score is 0.
        dp[0] = 0; 

        // `i` represents the number of operations performed so far (from 1 to m).
        for i in 1..=m {
            let current_multiplier = multipliers[i - 1] as i64;

            // `j` represents the number of elements taken from the left side of `nums`.
            // `i - j` represents the number of elements taken from the right side of `nums`.
            // `j` can range from 0 (all from right) to `i` (all from left).
            for j in (0..=i).rev() {
                let mut current_max_score = i64::MIN;

                // Option 1: The current `i`-th operation took an element from the left.
                // This means `j-1` elements were taken from the left in `i-1` operations.
                // The element taken is `nums[j-1]`.
                if j > 0 {
                    current_max_score = current_max_score.max(dp[j - 1] + (nums[j - 1] as i64) * current_multiplier);
                }

                // Option 2: The current `i`-th operation took an element from the right.
                // This means `j` elements were taken from the left in `i-1` operations.
                // The number of elements taken from the right is `i - j`.
                // The index of the rightmost element taken from `nums` is `n - (i - j)`.
                if i - j > 0 {
                    current_max_score = current_max_score.max(dp[j] + (nums[n - (i - j)] as i64) * current_multiplier);
                }

                dp[j] = current_max_score;
            }
        }

        // After `m` operations, the maximum score can be found by taking the maximum
        // value in the `dp` array, as `dp[j]` represents the maximum score
        // after `m` operations with `j` elements taken from the left.
        *dp.iter().max().unwrap() as i32
    }
}