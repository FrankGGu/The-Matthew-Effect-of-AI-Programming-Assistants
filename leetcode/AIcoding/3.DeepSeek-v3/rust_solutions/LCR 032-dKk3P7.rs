use std::collections::HashMap;

impl Solution {
    pub fn is_anagram(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let mut map = HashMap::new();

        for c in s.chars() {
            *map.entry(c).or_insert(0) += 1;
        }

        for c in t.chars() {
            let count = map.entry(c).or_insert(0);
            *count -= 1;
            if *count < 0 {
                return false;
            }
        }

        true
    }
}