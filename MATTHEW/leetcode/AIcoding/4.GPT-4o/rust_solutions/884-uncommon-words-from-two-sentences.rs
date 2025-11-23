use std::collections::HashMap;

impl Solution {
    pub fn uncommon_from_sentences(A: String, B: String) -> Vec<String> {
        let mut count = HashMap::new();
        for word in A.split_whitespace() {
            *count.entry(word).or_insert(0) += 1;
        }
        for word in B.split_whitespace() {
            *count.entry(word).or_insert(0) += 1;
        }
        count.into_iter()
            .filter(|&(_, v)| v == 1)
            .map(|(k, _)| k.to_string())
            .collect()
    }
}