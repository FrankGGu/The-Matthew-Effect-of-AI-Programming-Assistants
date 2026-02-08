use std::collections::HashMap;

impl Solution {
    pub fn duplicate_numbers_xor(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        let mut result = 0;

        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        for (&num, &count) in &freq {
            if count == 2 {
                result ^= num;
            }
        }

        result
    }
}