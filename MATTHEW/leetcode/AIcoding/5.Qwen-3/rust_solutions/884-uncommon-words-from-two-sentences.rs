impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn uncommon_from_sentences(s1: String, s2: String) -> Vec<String> {
        let mut count = HashMap::new();
        let words1: Vec<&str> = s1.split_whitespace().collect();
        let words2: Vec<&str> = s2.split_whitespace().collect();

        for word in &words1 {
            *count.entry(word.to_string()).or_insert(0) += 1;
        }

        for word in &words2 {
            *count.entry(word.to_string()).or_insert(0) += 1;
        }

        count.into_iter()
            .filter(|&(_, v)| v == 1)
            .map(|(k, _)| k)
            .collect()
    }
}
}