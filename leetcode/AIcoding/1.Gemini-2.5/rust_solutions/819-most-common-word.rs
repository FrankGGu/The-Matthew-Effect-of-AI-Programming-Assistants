use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn most_common_word(paragraph: String, banned: Vec<String>) -> String {
        let banned_set: HashSet<String> = banned.into_iter().collect();
        let mut word_counts: HashMap<String, i32> = HashMap::new();

        let normalized_paragraph: String = paragraph
            .chars()
            .map(|c| {
                if c.is_ascii_alphabetic() {
                    c.to_ascii_lowercase()
                } else {
                    ' '
                }
            })
            .collect();

        for word in normalized_paragraph.split_whitespace() {
            let word_str = word.to_string();
            if !banned_set.contains(&word_str) {
                *word_counts.entry(word_str).or_insert(0) += 1;
            }
        }

        let mut max_count = 0;
        let mut result_word = String::new();

        for (word, count) in word_counts {
            if count > max_count {
                max_count = count;
                result_word = word;
            }
        }

        result_word
    }
}