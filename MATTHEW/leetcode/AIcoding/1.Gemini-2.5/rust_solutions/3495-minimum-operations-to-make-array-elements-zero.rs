use std::collections::HashSet;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut distinct_positives = HashSet::new();
        for num in nums {
            if num > 0 {
                distinct_positives.insert(num);
            }
        }
        distinct_positives.len() as i32
    }
}