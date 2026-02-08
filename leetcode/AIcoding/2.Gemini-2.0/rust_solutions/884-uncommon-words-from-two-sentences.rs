use std::collections::HashMap;

impl Solution {
    pub fn uncommon_from_sentences(s1: String, s2: String) -> Vec<String> {
        let mut counts = HashMap::new();

        for word in s1.split_whitespace() {
            *counts.entry(word).or_insert(0) += 1;
        }

        for word in s2.split_whitespace() {
            *counts.entry(word).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        for (word, count) in counts {
            if count == 1 {
                result.push(word.to_string());
            }
        }

        result
    }
}