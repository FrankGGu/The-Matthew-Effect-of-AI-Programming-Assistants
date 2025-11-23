use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn close_strings(word1: String, word2: String) -> bool {
        if word1.len() != word2.len() {
            return false;
        }

        let mut freq1 = HashMap::new();
        let mut freq2 = HashMap::new();

        for c in word1.chars() {
            *freq1.entry(c).or_insert(0) += 1;
        }

        for c in word2.chars() {
            *freq2.entry(c).or_insert(0) += 1;
        }

        let keys1: HashSet<_> = freq1.keys().collect();
        let keys2: HashSet<_> = freq2.keys().collect();
        if keys1 != keys2 {
            return false;
        }

        let mut counts1: Vec<_> = freq1.values().collect();
        let mut counts2: Vec<_> = freq2.values().collect();
        counts1.sort();
        counts2.sort();

        counts1 == counts2
    }
}