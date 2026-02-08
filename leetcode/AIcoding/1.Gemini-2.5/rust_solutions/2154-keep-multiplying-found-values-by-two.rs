use std::collections::HashSet;

impl Solution {
    pub fn find_final_value(nums: Vec<i32>, mut original: i32) -> i32 {
        let num_set: HashSet<i32> = nums.into_iter().collect();

        loop {
            if num_set.contains(&original) {
                original *= 2;
            } else {
                break;
            }
        }
        original
    }
}