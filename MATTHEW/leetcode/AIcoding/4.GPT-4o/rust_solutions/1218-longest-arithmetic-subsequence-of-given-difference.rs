use std::collections::HashMap;

impl Solution {
    pub fn longest_subsequence(arr: Vec<i32>, difference: i32) -> i32 {
        let mut dp = HashMap::new();
        let mut max_length = 0;

        for &num in &arr {
            let length = dp.get(&(num - difference)).unwrap_or(&0) + 1;
            dp.insert(num, length);
            max_length = max_length.max(length);
        }

        max_length
    }
}