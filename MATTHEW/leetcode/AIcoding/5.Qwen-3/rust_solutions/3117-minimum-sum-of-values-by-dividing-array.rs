impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn minimum_sum(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut dp = vec![0; n];
        dp[0] = nums[0];

        for i in 1..n {
            let mut min_val = i32::MAX;
            for j in (i as isize - k as isize).max(0) as usize..i {
                if nums[j] < nums[i] {
                    min_val = min_val.min(dp[j]);
                }
            }
            if min_val != i32::MAX {
                dp[i] = min_val + nums[i];
            } else {
                return -1;
            }
        }

        dp[n - 1]
    }
}
}