use std::collections::HashMap;

impl Solution {
    pub fn find_substring(s: String, words: Vec<String>) -> Vec<i32> {
        let s = s.as_bytes();
        let word_len = words[0].len();
        let total_len = word_len * words.len();
        if s.len() < total_len {
            return vec![];
        }

        let mut word_count = HashMap::new();
        for word in &words {
            *word_count.entry(word.as_bytes()).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        for i in 0..=s.len() - total_len {
            let mut seen = HashMap::new();
            let mut j = 0;
            while j < words.len() {
                let start = i + j * word_len;
                let end = start + word_len;
                let current_word = &s[start..end];
                if !word_count.contains_key(current_word) {
                    break;
                }
                *seen.entry(current_word).or_insert(0) += 1;
                if seen[current_word] > word_count[current_word] {
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