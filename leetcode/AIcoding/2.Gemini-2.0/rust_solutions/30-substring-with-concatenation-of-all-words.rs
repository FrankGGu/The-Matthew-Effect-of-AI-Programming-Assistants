use std::collections::HashMap;

impl Solution {
    pub fn find_substring(s: String, words: Vec<String>) -> Vec<i32> {
        let mut result = Vec::new();
        if words.is_empty() {
            return result;
        }

        let word_len = words[0].len();
        let total_len = word_len * words.len();
        if s.len() < total_len {
            return result;
        }

        let mut word_counts = HashMap::new();
        for word in &words {
            *word_counts.entry(word.as_str()).or_insert(0) += 1;
        }

        for i in 0..=s.len() - total_len {
            let mut seen_words = HashMap::new();
            let mut j = 0;
            while j < words.len() {
                let word = &s[i + j * word_len..i + (j + 1) * word_len];
                if !word_counts.contains_key(word) {
                    break;
                }
                *seen_words.entry(word).or_insert(0) += 1;
                if seen_words[word] > *word_counts.get(word).unwrap() {
                    break;
                }
                j += 1;
            }

            if j == words.len() {
                result.push(i as i32);
            }
        }

        result
    }
}