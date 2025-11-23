impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn number_game(mut nums: Vec<i32>) -> Vec<i32> {
        nums.sort();
        let mut result = Vec::new();
        for i in 0..nums.len() / 2 {
            result.push(nums[i * 2 + 1]);
            result.push(nums[i * 2]);
        }
        result
    }
}
}