use std::collections::HashMap;

impl Solution {
    pub fn ways_to_partition(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut sum = 0i64;
        for &num in &nums {
            sum += num as i64;
        }

        let mut count = 0;
        let mut prefix_sum = 0i64;
        for i in 0..n {
            if prefix_sum + (k - nums[i]) as i64 == sum - (prefix_sum + nums[i] as i64) {
                count += 1;
            }
            prefix_sum += nums[i] as i64;
        }

        count
    }
}