impl Solution {

use std::cmp;

impl Solution {
    pub fn count_alternating_subarrays(nums: Vec<i32>) -> i32 {
        let mut result = 0;
        let mut current_length = 1;

        for i in 1..nums.len() {
            if nums[i] != nums[i - 1] {
                current_length += 1;
            } else {
                current_length = 1;
            }
            result += current_length;
        }

        result
    }
}
}