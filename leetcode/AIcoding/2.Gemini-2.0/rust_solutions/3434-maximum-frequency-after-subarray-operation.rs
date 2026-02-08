use std::collections::HashMap;

impl Solution {
    pub fn max_frequency(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut left = 0;
        let mut right = 0;
        let mut sum = 0;
        let mut max_freq = 0;

        while right < nums.len() {
            sum += nums[right];

            while (right - left + 1) as i64 * nums[right] as i64 - sum as i64 > k as i64 {
                sum -= nums[left];
                left += 1;
            }

            max_freq = max_freq.max((right - left + 1) as i32);
            right += 1;
        }

        max_freq
    }
}