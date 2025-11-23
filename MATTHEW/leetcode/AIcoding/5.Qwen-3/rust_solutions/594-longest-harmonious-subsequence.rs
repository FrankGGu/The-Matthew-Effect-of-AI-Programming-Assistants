impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn find_longest_harmonious_subsequence(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut max_length = 0;
        for (&key, &value) in &count {
            if let Some(&next_value) = count.get(&(key + 1)) {
                max_length = std::cmp::max(max_length, value + next_value);
            }
        }

        max_length
    }
}
}