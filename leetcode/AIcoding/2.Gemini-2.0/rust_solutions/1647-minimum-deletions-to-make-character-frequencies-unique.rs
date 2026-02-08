use std::collections::{HashSet, HashMap};

impl Solution {
    pub fn min_deletions(s: String) -> i32 {
        let mut freq_map = HashMap::new();
        for c in s.chars() {
            *freq_map.entry(c).or_insert(0) += 1;
        }

        let mut frequencies: Vec<i32> = freq_map.values().cloned().collect();
        frequencies.sort_by(|a, b| b.cmp(a));

        let mut deletions = 0;
        let mut seen = HashSet::new();

        for i in 0..frequencies.len() {
            let mut freq = frequencies[i];
            while freq > 0 && seen.contains(&freq) {
                freq -= 1;
                deletions += 1;
            }
            seen.insert(freq);
        }

        deletions
    }
}