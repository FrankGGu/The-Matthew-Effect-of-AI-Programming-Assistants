use std::collections::HashMap;

impl Solution {
    pub fn min_deletions(s: String, k: i32) -> i32 {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }
        let mut counts: Vec<i32> = freq.values().cloned().collect();
        counts.sort_unstable();
        let mut res = 0;
        let mut remaining = k;
        let mut i = 0;
        while i < counts.len() && counts[i] <= remaining {
            remaining -= counts[i];
            i += 1;
        }
        if i < counts.len() {
            res += counts[i] - remaining;
            i += 1;
            while i < counts.len() {
                res += counts[i];
                i += 1;
            }
        }
        res
    }
}