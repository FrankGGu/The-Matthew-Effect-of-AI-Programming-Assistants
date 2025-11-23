impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn majority_element(nums: Vec<i32>) -> Vec<i32> {
        let mut count = HashMap::new();
        let mut result = Vec::new();
        let n = nums.len() as i32;

        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        for (&key, &value) in &count {
            if value > n / 3 {
                result.push(key);
            }
        }

        result
    }
}
}