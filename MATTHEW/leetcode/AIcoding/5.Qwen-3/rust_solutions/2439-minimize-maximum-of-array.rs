impl Solution {

use std::cmp::max;

struct Solution {}

impl Solution {
    pub fn minimize_array_value(mut nums: Vec<i32>) -> i32 {
        let mut prefix_sum = 0;
        let mut result = 0;

        for i in 0..nums.len() {
            prefix_sum += nums[i];
            let average = (prefix_sum as f64 / (i + 1) as f64).ceil() as i32;
            result = max(result, average);
        }

        result
    }
}
}