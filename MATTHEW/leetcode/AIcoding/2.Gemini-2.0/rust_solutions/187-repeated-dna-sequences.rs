use std::collections::HashSet;

impl Solution {
    pub fn find_repeated_dna_sequences(s: String) -> Vec<String> {
        let mut seen = HashSet::new();
        let mut repeated = HashSet::new();
        let mut result = Vec::new();
        if s.len() < 10 {
            return result;
        }

        for i in 0..=s.len() - 10 {
            let sub = &s[i..i + 10];
            if !seen.insert(sub.to_string()) {
                if repeated.insert(sub.to_string()) {
                    result.push(sub.to_string());
                }
            }
        }

        result
    }
}