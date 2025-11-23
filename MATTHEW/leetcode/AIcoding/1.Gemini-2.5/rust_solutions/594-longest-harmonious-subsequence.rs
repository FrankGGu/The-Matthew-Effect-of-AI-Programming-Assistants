use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn find_lhs(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for num in nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut max_len = 0;

        for (&num, &count) in &counts {
            if let Some(&next_count) = counts.get(&(num + 1)) {
                max_len = max(max_len, count + next_count);
            }
        }

        max_len
    }
}