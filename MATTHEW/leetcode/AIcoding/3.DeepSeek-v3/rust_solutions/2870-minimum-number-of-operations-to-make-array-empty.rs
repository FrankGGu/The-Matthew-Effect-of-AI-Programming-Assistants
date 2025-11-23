use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut operations = 0;
        for &count in freq.values() {
            if count == 1 {
                return -1;
            }
            operations += (count + 2) / 3;
        }
        operations
    }
}