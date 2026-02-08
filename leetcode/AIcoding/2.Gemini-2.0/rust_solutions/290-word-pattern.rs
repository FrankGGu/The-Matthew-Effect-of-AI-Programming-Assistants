use std::collections::HashMap;

impl Solution {
    pub fn word_pattern(pattern: String, s: String) -> bool {
        let pattern_chars: Vec<char> = pattern.chars().collect();
        let words: Vec<&str> = s.split_whitespace().collect();

        if pattern_chars.len() != words.len() {
            return false;
        }

        let mut char_to_word: HashMap<char, &str> = HashMap::new();
        let mut word_to_char: HashMap<&str, char> = HashMap::new();

        for i in 0..pattern_chars.len() {
            let c = pattern_chars[i];
            let word = words[i];

            if !char_to_word.contains_key(&c) && !word_to_char.contains_key(word) {
                char_to_word.insert(c, word);
                word_to_char.insert(word, c);
            } else if let Some(&mapped_word) = char_to_word.get(&c) {
                if mapped_word != word {
                    return false;
                }
            } else if let Some(&mapped_char) = word_to_char.get(word) {
                if mapped_char != c {
                    return false;
                }
            } else {
                return false;
            }
        }

        true
    }
}