use std::collections::HashMap;

impl Solution {
    pub fn uncommon_from_sentences(s1: String, s2: String) -> Vec<String> {
        let mut word_count = HashMap::new();

        for word in s1.split_whitespace() {
            *word_count.entry(word.to_string()).or_insert(0) += 1;
        }

        for word in s2.split_whitespace() {
            *word_count.entry(word.to_string()).or_insert(0) += 1;
        }

        word_count.into_iter()
            .filter(|(_, count)| *count == 1)
            .map(|(word, _)| word)
            .collect()
    }
}