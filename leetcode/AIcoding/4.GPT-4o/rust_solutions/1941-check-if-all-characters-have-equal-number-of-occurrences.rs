use std::collections::HashMap;

impl Solution {
    pub fn are_occurrences_equal(s: String) -> bool {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        let first_count = count.values().next().unwrap();
        count.values().all(|&v| v == *first_count)
    }
}