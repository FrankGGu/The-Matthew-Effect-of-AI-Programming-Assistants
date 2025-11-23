impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn are_occurrences_equal(s: String) -> bool {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        let first = count.values().next().unwrap();
        for &v in count.values() {
            if v != *first {
                return false;
            }
        }
        true
    }
}
}