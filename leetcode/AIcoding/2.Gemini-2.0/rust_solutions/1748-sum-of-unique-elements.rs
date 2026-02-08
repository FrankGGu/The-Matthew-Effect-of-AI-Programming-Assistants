use std::collections::HashMap;

impl Solution {
    pub fn sum_of_unique(nums: Vec<i32>) -> i32 {
        let mut counts = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut sum = 0;
        for (&num, &count) in &counts {
            if count == 1 {
                sum += num;
            }
        }

        sum
    }
}