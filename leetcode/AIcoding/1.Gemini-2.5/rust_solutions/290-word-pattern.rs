use std::collections::HashMap;

impl Solution {
    pub fn word_pattern(pattern: String, s: String) -> bool {
        let words: Vec<&str> = s.split(' ').collect();

        if pattern.len() != words.len() {
            return false;
        }

        let mut char_to_word: HashMap<char, &str> = HashMap::new();
        let mut word_to_char: HashMap<&str, char> = HashMap::new();

        for (i, char_p) in pattern.chars().enumerate() {
            let word_s = words[i];

            match char_to_word.get(&char_p) {
                Some(&mapped_word) => {
                    if mapped_word != word_s {
                        return false;
                    }
                }
                None => {
                    char_to_word.insert(char_p, word_s);
                }
            }

            match word_to_char.get(&word_s) {
                Some(&mapped_char) => {
                    if mapped_char != char_p {
                        return false;
                    }
                }
                None => {
                    word_to_char.insert(word_s, char_p);
                }
            }
        }

        true
    }
}