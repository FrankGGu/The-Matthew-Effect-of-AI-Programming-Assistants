use std::collections::HashMap;

impl Solution {
    pub fn count_complete_day_pairs(hours: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut remainder_counts = HashMap::new();

        for &hour in hours.iter() {
            let remainder = hour % 24;
            let complement = (24 - remainder) % 24;
            count += *remainder_counts.get(&complement).unwrap_or(&0);
            *remainder_counts.entry(remainder).or_insert(0) += 1;
        }

        count
    }
}