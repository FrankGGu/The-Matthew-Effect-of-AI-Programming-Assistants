use std::collections::HashMap;

impl Solution {
    pub fn find_repeated_dna_sequences(s: String) -> Vec<String> {
        let mut seen = HashMap::new();
        let mut res = Vec::new();
        let s = s.as_bytes();

        if s.len() < 10 {
            return res;
        }

        for i in 0..=s.len() - 10 {
            let seq = &s[i..i + 10];
            let count = seen.entry(seq).or_insert(0);
            *count += 1;
            if *count == 2 {
                res.push(String::from_utf8(seq.to_vec()).unwrap());
            }
        }

        res
    }
}