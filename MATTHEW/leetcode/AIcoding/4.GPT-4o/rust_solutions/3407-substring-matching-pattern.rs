pub fn find_and_replace_pattern(words: Vec<String>, pattern: String) -> Vec<String> {
    fn matches(word: &str, pattern: &str) -> bool {
        let mut w_to_p = std::collections::HashMap::new();
        let mut p_to_w = std::collections::HashMap::new();
        for (w_char, p_char) in word.chars().zip(pattern.chars()) {
            if w_to_p.insert(w_char, p_char) != p_to_w.insert(p_char, w_char) {
                return false;
            }
        }
        true
    }

    words.into_iter().filter(|word| matches(word, &pattern)).collect()
}