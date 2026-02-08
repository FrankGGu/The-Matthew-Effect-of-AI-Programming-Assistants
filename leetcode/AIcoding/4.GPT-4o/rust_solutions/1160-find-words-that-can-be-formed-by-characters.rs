use std::collections::HashMap;

impl Solution {
    pub fn count_characters(words: Vec<String>, chars: String) -> String {
        let mut char_count = HashMap::new();
        for ch in chars.chars() {
            *char_count.entry(ch).or_insert(0) += 1;
        }

        let mut total_length = 0;
        for word in words {
            let mut word_count = HashMap::new();
            for ch in word.chars() {
                *word_count.entry(ch).or_insert(0) += 1;
            }
            if word_count.iter().all(|(k, &v)| char_count.get(k).unwrap_or(&0) >= &v) {
                total_length += word.len();
            }
        }

        total_length
    }
}