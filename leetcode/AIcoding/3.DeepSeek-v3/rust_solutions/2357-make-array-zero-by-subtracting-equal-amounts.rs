use std::collections::HashSet;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut unique_nums: HashSet<i32> = nums.into_iter().filter(|&x| x != 0).collect();
        unique_nums.len() as i32
    }
}