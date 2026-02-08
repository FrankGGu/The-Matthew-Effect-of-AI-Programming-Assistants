impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        use std::collections::HashSet;

        let mut unique_positives = HashSet::new();
        for num in nums {
            if num > 0 {
                unique_positives.insert(num);
            }
        }
        unique_positives.len() as i32
    }
}