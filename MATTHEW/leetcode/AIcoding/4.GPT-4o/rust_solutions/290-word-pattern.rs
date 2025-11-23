impl Solution {
    pub fn word_pattern(pattern: String, s: String) -> bool {
        let words: Vec<&str> = s.split_whitespace().collect();
        if pattern.len() != words.len() {
            return false;
        }

        let mut char_to_word = std::collections::HashMap::new();
        let mut word_to_char = std::collections::HashMap::new();

        for (c, word) in pattern.chars().zip(words.iter()) {
            if char_to_word.insert(c, word) != None {
                if char_to_word[&c] != word {
                    return false;
                }
            }
            if word_to_char.insert(word, c) != None {
                if word_to_char[word] != c {
                    return false;
                }
            }
        }
        true
    }
}