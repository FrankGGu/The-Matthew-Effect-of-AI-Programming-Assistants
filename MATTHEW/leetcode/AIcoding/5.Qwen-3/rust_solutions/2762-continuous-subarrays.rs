impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn continuous_subarrays(mut nums: Vec<i32>) -> i32 {
        let mut result = 0;
        let mut set = HashSet::new();
        let mut left = 0;

        for right in 0..nums.len() {
            set.insert(nums[right]);

            while *set.iter().max().unwrap() - *set.iter().min().unwrap() > 2 {
                set.remove(&nums[left]);
                left += 1;
            }

            result += right - left + 1;
        }

        result as i32
    }
}
}