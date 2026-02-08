impl Solution {
    pub fn find_and_replace_pattern(words: Vec<String>, pattern: String) -> Vec<String> {
        let mut result = Vec::new();

        for word in words {
            if Solution::matches(&word, &pattern) {
                result.push(word);
            }
        }

        result
    }

    fn matches(word: &str, pattern: &str) -> bool {
        let mut map_word = std::collections::HashMap::new();
        let mut map_pattern = std::collections::HashMap::new();

        for (w, p) in word.chars().zip(pattern.chars()) {
            let w_entry = map_word.entry(w).or_insert(p);
            let p_entry = map_pattern.entry(p).or_insert(w);
            if *w_entry != p || *p_entry != w {
                return false;
            }
        }
        true
    }
}