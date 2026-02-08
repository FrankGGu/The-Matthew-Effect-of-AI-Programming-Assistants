use std::collections::HashSet;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut distinct_positive_numbers = HashSet::new();
        for num in nums {
            if num > 0 {
                distinct_positive_numbers.insert(num);
            }
        }
        distinct_positive_numbers.len() as i32
    }
}