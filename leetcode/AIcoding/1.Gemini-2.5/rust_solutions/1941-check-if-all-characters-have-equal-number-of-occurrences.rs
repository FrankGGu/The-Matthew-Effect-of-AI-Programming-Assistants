use std::collections::HashMap;

impl Solution {
    pub fn are_occurrences_equal(s: String) -> bool {
        let mut counts = HashMap::new();
        for c in s.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        if counts.is_empty() {
            return true;
        }

        let mut first_count = 0;
        for &count in counts.values() {
            if first_count == 0 {
                first_count = count;
            } else if count != first_count {
                return false;
            }
        }
        true
    }
}