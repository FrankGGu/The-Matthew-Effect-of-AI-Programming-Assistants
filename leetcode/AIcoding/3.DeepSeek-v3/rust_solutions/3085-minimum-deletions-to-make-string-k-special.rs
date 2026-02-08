use std::collections::HashMap;

impl Solution {
    pub fn minimum_deletions(s: String, k: i32) -> i32 {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }
        let mut counts: Vec<i32> = freq.values().cloned().collect();
        counts.sort_unstable();
        let mut res = i32::MAX;
        for i in 0..counts.len() {
            let target = counts[i];
            let mut deletions = 0;
            for j in 0..counts.len() {
                if counts[j] < target {
                    deletions += counts[j];
                } else if counts[j] > target + k {
                    deletions += counts[j] - (target + k);
                }
            }
            res = res.min(deletions);
        }
        res
    }
}