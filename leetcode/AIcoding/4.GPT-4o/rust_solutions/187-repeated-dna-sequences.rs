use std::collections::HashSet;

impl Solution {
    pub fn find_repeated_dna_sequences(s: String) -> Vec<String> {
        let mut seen = HashSet::new();
        let mut repeated = HashSet::new();

        for i in 0..s.len() - 9 {
            let seq = &s[i..i + 10];
            if !seen.insert(seq) {
                repeated.insert(seq.to_string());
            }
        }

        repeated.into_iter().collect()
    }
}