use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = HashMap::new();
        for &num in nums.iter() {
            *freq.entry(num).or_insert(0) += 1;
        }
        let mut operations = 0;
        for i in 1..=k {
            if !freq.contains_key(&i) {
                operations += 1;
            }
        }
        operations
    }
}