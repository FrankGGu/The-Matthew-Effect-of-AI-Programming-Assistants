use std::collections::HashMap;

impl Solution {
    pub fn find_lhs(nums: Vec<i32>) -> i32 {
        let mut counts = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut max_len = 0;
        for (&num, &count) in &counts {
            if counts.contains_key(&(num + 1)) {
                max_len = max_len.max(count + counts[&(num + 1)]);
            }
        }

        max_len
    }
}