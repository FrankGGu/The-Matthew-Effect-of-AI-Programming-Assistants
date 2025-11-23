use std::collections::HashMap;

impl Solution {
    pub fn word_pattern(pattern: String, s: String) -> bool {
        let words: Vec<&str> = s.split_whitespace().collect();
        if pattern.len() != words.len() {
            return false;
        }

        let mut char_to_word = HashMap::new();
        let mut word_to_char = HashMap::new();

        for (i, c) in pattern.chars().enumerate() {
            let word = words[i];
            if let Some(&mapped_word) = char_to_word.get(&c) {
                if mapped_word != word {
                    return false;
                }
            } else {
                char_to_word.insert(c, word);
            }

            if let Some(&mapped_char) = word_to_char.get(word) {
                if mapped_char != c {
                    return false;
                }
            } else {
                word_to_char.insert(word, c);
            }
        }

        true
    }
}