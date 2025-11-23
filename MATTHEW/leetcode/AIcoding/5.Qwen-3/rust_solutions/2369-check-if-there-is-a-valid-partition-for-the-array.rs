impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn valid_partition(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut dp = vec![false; n];

        if n >= 3 && nums[0] == nums[1] && nums[1] == nums[2] {
            dp[2] = true;
        }

        if n >= 2 && nums[0] == nums[1] {
            dp[1] = true;
        }

        for i in 3..n {
            if dp[i - 3] && nums[i] == nums[i - 1] && nums[i - 1] == nums[i - 2] {
                dp[i] = true;
            } else if dp[i - 2] && nums[i] == nums[i - 1] {
                dp[i] = true;
            } else if dp[i - 1] && nums[i] == nums[i - 1] + 1 && nums[i - 1] == nums[i - 2] + 1 {
                dp[i] = true;
            }
        }

        dp[n - 1]
    }
}
}