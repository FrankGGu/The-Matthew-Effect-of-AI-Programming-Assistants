use std::collections::HashSet;

impl Solution {
    pub fn find_final_value(nums: Vec<i32>, original: i32) -> i32 {
        let mut set: HashSet<i32> = nums.into_iter().collect();
        let mut current = original;
        while set.contains(&current) {
            current *= 2;
        }
        current
    }
}