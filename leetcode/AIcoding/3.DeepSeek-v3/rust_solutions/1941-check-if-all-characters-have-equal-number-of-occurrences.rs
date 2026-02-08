use std::collections::HashMap;

impl Solution {
    pub fn are_occurrences_equal(s: String) -> bool {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }
        let first_count = freq.values().next().unwrap();
        freq.values().all(|&count| count == *first_count)
    }
}