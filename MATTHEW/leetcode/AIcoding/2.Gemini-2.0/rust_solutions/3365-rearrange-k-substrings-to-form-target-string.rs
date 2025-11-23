use std::collections::HashMap;

impl Solution {
    pub fn rearrange_k_substrings(s: String, target: String, k: i32) -> bool {
        let mut s_freq: HashMap<char, i32> = HashMap::new();
        let mut target_freq: HashMap<char, i32> = HashMap::new();

        for c in s.chars() {
            *s_freq.entry(c).or_insert(0) += 1;
        }

        for c in target.chars() {
            *target_freq.entry(c).or_insert(0) += 1;
        }

        for (c, count) in target_freq.iter() {
            if !s_freq.contains_key(c) || s_freq[c] < *count {
                return false;
            }
        }

        let mut min_occurrences = i32::MAX;
        for (c, count) in target_freq.iter() {
            min_occurrences = min_occurrences.min(s_freq[c] / count);
        }

        min_occurrences >= k
    }
}