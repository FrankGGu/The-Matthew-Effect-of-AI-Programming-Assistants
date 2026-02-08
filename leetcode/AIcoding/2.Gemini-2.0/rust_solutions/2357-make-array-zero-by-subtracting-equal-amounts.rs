use std::collections::HashSet;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut set = HashSet::new();
        for &num in &nums {
            if num > 0 {
                set.insert(num);
            }
        }
        set.len() as i32
    }
}