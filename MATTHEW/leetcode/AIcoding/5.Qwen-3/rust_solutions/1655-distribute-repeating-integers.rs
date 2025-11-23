impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn rearrange_students(mut nums: Vec<i32>, k: i32) -> bool {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut freq: Vec<_> = count.into_values().collect();
        freq.sort_by(|a, b| b.cmp(a));

        let mut max_freq = freq[0];
        let mut remaining = freq.iter().skip(1).sum::<i32>();

        if max_freq > (remaining + 1) / (k - 1) {
            return false;
        }

        true
    }
}
}