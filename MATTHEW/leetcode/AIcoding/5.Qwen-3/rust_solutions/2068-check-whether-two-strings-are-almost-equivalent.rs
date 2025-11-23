impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn close_strings(word1: String, word2: String) -> bool {
        if word1.len() != word2.len() {
            return false;
        }

        let mut count1 = HashMap::new();
        let mut count2 = HashMap::new();

        for c in word1.chars() {
            *count1.entry(c).or_insert(0) += 1;
        }

        for c in word2.chars() {
            *count2.entry(c).or_insert(0) += 1;
        }

        if count1.keys().collect::<Vec<_>>() != count2.keys().collect::<Vec<_>>() {
            return false;
        }

        let mut freq1: Vec<usize> = count1.values().cloned().collect();
        let mut freq2: Vec<usize> = count2.values().cloned().collect();

        freq1.sort();
        freq2.sort();

        freq1 == freq2
    }
}
}