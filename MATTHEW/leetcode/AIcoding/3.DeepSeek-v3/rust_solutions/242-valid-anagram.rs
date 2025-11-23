use std::collections::HashMap;

impl Solution {
    pub fn is_anagram(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let mut s_counts = HashMap::new();
        let mut t_counts = HashMap::new();

        for c in s.chars() {
            *s_counts.entry(c).or_insert(0) += 1;
        }

        for c in t.chars() {
            *t_counts.entry(c).or_insert(0) += 1;
        }

        s_counts == t_counts
    }
}