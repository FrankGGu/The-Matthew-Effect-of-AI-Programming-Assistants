use std::collections::HashMap;

impl Solution {
    pub fn min_set_size(arr: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &arr {
            *freq.entry(num).or_insert(0) += 1;
        }
        let mut counts: Vec<i32> = freq.values().cloned().collect();
        counts.sort_unstable_by(|a, b| b.cmp(a));

        let mut removed = 0;
        let mut sets = 0;
        let half_size = arr.len() / 2;

        for count in counts {
            removed += count;
            sets += 1;
            if removed >= half_size {
                return sets;
            }
        }

        sets
    }
}