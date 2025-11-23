impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn find_repeated_dna_sequences(s: String) -> Vec<String> {
        let mut seen = HashSet::new();
        let mut result = HashSet::new();
        let mut left = 0;
        let mut right = 0;
        let len = s.len();

        while right < len {
            if right - left + 1 == 10 {
                let substr = &s[left..right + 1];
                if seen.contains(substr) {
                    result.insert(substr.to_string());
                } else {
                    seen.insert(substr.to_string());
                }
                left += 1;
            }
            right += 1;
        }

        result.into_iter().collect()
    }
}
}