impl Solution {
    pub fn valid_partition(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut dp = vec![false; n + 1];
        dp[0] = true;

        for i in 1..=n {
            // Check for a 2-element partition ending at index i-1
            // This means nums[i-2] and nums[i-1] form a valid pair
            if i >= 2 {
                if nums[i - 1] == nums[i - 2] {
                    dp[i] |= dp[i - 2];
                }
            }

            // Check for a 3-element partition ending at index i-1
            // This means nums[i-3], nums[i-2], nums[i-1] form a valid triplet
            if i >= 3 {
                // Case 1: Three equal elements
                if nums[i - 1] == nums[i - 2] && nums[i - 2] == nums[i - 3] {
                    dp[i] |= dp[i - 3];
                }
                // Case 2: Three consecutive increasing elements
                if nums[i - 1] == nums[i - 2] + 1 && nums[i - 2] == nums[i - 3] + 1 {
                    dp[i] |= dp[i - 3];
                }
            }
        }

        dp[n]
    }
}