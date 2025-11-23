impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn num_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut total = 0;
        let mut prefix_sum = 0;
        let mut left = 0;

        for right in 0..n {
            prefix_sum += nums[right];

            while prefix_sum * (right as i32 - left as i32 + 1) >= k {
                prefix_sum -= nums[left];
                left += 1;
            }

            total += right as i32 - left as i32 + 1;
        }

        total
    }
}
}