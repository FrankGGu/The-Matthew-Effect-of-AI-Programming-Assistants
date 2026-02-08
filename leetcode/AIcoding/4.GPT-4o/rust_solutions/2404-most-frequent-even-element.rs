impl Solution {
    pub fn most_frequent_even(nums: Vec<i32>) -> i32 {
        use std::collections::HashMap;

        let mut counts = HashMap::new();
        for &num in &nums {
            if num % 2 == 0 {
                *counts.entry(num).or_insert(0) += 1;
            }
        }

        counts.into_iter().max_by(|a, b| {
            if a.1 == b.1 {
                a.0.cmp(&b.0)
            } else {
                a.1.cmp(&b.1)
            }
        }).map_or(-1, |(num, _)| num)
    }
}