use std::collections::HashMap;

impl Solution {
    pub fn find_and_replace_pattern(words: Vec<String>, pattern: String) -> Vec<String> {
        let mut result = Vec::new();

        for word in words {
            if Self::is_match(&word, &pattern) {
                result.push(word);
            }
        }

        result
    }

    fn is_match(word: &str, pattern: &str) -> bool {
        let mut p_to_w: HashMap<char, char> = HashMap::new();
        let mut w_to_p: HashMap<char, char> = HashMap::new();

        for (p_char, w_char) in pattern.chars().zip(word.chars()) {
            match p_to_w.entry(p_char) {
                std::collections::hash_map::Entry::Occupied(entry) => {
                    if *entry.get() != w_char {
                        return false;
                    }
                }
                std::collections::hash_map::Entry::Vacant(entry) => {
                    entry.insert(w_char);
                }
            }

            match w_to_p.entry(w_char) {
                std::collections::hash_map::Entry::Occupied(entry) => {
                    if *entry.get() != p_char {
                        return false;
                    }
                }
                std::collections::hash_map::Entry::Vacant(entry) => {
                    entry.insert(p_char);
                }
            }
        }

        true
    }
}