use std::collections::HashMap;

impl Solution {
    pub fn are_occurrences_equal(s: String) -> bool {
        let mut counts: HashMap<char, i32> = HashMap::new();
        for c in s.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        if counts.is_empty() {
            return true;
        }

        let mut first_count = 0;
        for (_, count) in &counts {
            first_count = *count;
            break;
        }

        for (_, count) in &counts {
            if *count != first_count {
                return false;
            }
        }

        true
    }
}