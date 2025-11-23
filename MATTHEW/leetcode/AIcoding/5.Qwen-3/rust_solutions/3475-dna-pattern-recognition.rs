impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn find_repeated_dna_sequences(s: String) -> Vec<String> {
        let mut seen = HashMap::new();
        let mut result = Vec::new();
        let mut left = 0;
        let mut right = 0;
        let n = s.len();

        while right < n {
            if right - left + 1 == 10 {
                let sequence = &s[left..right + 1];
                *seen.entry(sequence.to_string()).or_insert(0) += 1;
                if *seen.get(sequence).unwrap() > 1 {
                    result.push(sequence.to_string());
                }
                left += 1;
            }
            right += 1;
        }

        result
    }
}
}