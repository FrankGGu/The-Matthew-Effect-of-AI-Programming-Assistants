impl Solution {
    pub fn split_words_by_separator(words: Vec<String>, separator: char) -> Vec<String> {
        let mut result = Vec::new();
        for word in words {
            let parts: Vec<&str> = word.split(separator).filter(|s| !s.is_empty()).collect();
            for part in parts {
                result.push(part.to_string());
            }
        }
        result
    }
}