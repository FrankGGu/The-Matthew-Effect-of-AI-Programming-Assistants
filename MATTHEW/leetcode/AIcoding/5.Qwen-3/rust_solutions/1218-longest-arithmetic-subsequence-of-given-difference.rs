impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_arith_seq_length(nums: Vec<i32>, difference: i32) -> i32 {
        let mut dp = HashMap::new();
        let mut max_len = 0;

        for &num in &nums {
            let prev = dp.get(&(num - difference)).unwrap_or(&0);
            dp.insert(num, prev + 1);
            max_len = std::cmp::max(max_len, prev + 1);
        }

        max_len
    }
}
}