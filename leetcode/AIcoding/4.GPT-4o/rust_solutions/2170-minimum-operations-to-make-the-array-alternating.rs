use std::collections::HashMap;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut freq: Vec<_> = count.iter().collect();
        freq.sort_by(|a, b| b.1.cmp(a.1));

        let (first, second) = if freq.len() > 1 {
            (freq[0], freq[1])
        } else {
            (freq[0], &(0, &0))
        };

        let mut ops = 0;
        for (i, &num) in nums.iter().enumerate() {
            if (i % 2 == 0 && num != first.0) || (i % 2 == 1 && num != second.0) {
                ops += 1;
            }
        }

        ops
    }
}