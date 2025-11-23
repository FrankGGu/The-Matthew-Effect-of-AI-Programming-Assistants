use std::collections::HashMap;

impl Solution {
    pub fn find_repeated_dna_sequences(s: String) -> Vec<String> {
        let mut seen = HashMap::new();
        let mut res = Vec::new();
        let s_chars: Vec<char> = s.chars().collect();

        if s_chars.len() < 10 {
            return res;
        }

        for i in 0..=s_chars.len() - 10 {
            let seq: String = s_chars[i..i + 10].iter().collect();
            *seen.entry(seq.clone()).or_insert(0) += 1;
            if seen[&seq] == 2 {
                res.push(seq);
            }
        }

        res
    }
}