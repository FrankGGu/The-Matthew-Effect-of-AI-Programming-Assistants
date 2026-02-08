impl Solution {
    pub fn can_construct(target: String, substrings: Vec<String>) -> bool {
        use std::collections::HashMap;

        let mut target_count = HashMap::new();
        for c in target.chars() {
            *target_count.entry(c).or_insert(0) += 1;
        }

        let mut substring_count = HashMap::new();
        for substring in substrings {
            for c in substring.chars() {
                *substring_count.entry(c).or_insert(0) += 1;
            }
        }

        for (c, &count) in target_count.iter() {
            if substring_count.get(c).unwrap_or(&0) < &count {
                return false;
            }
        }
        true
    }
}