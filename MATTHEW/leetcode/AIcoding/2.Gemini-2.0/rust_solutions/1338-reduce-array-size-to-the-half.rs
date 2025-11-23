use std::collections::HashMap;

impl Solution {
    pub fn min_set_size(arr: Vec<i32>) -> i32 {
        let mut counts = HashMap::new();
        for &num in &arr {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut frequencies: Vec<i32> = counts.values().cloned().collect();
        frequencies.sort_by(|a, b| b.cmp(a));

        let mut removed = 0;
        let mut count = 0;
        let half = arr.len() / 2;

        for &freq in &frequencies {
            removed += freq;
            count += 1;
            if removed >= half {
                return count;
            }
        }

        count
    }
}