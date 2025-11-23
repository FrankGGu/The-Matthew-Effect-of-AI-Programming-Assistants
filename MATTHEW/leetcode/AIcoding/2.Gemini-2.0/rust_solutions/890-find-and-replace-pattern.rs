use std::collections::HashMap;

impl Solution {
    pub fn find_and_replace_pattern(words: Vec<String>, pattern: String) -> Vec<String> {
        let mut result = Vec::new();
        for word in words {
            if word.len() != pattern.len() {
                continue;
            }
            if Solution::matches(&word, &pattern) {
                result.push(word);
            }
        }
        result
    }

    fn matches(word: &str, pattern: &str) -> bool {
        let mut word_to_pattern = HashMap::new();
        let mut pattern_to_word = HashMap::new();

        for (w_char, p_char) in word.chars().zip(pattern.chars()) {
            if !word_to_pattern.contains_key(&w_char) {
                word_to_pattern.insert(w_char, p_char);
            }
            if !pattern_to_word.contains_key(&p_char) {
                pattern_to_word.insert(p_char, w_char);
            }

            if word_to_pattern[&w_char] != p_char || pattern_to_word[&p_char] != w_char {
                return false;
            }
        }
        true
    }
}