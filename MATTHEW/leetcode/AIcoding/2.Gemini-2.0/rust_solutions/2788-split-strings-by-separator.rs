impl Solution {
    pub fn split_words_by_separator(words: Vec<String>, separator: char) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        for word in words {
            let parts: Vec<&str> = word.split(separator).collect();
            for part in parts {
                if !part.is_empty() {
                    result.push(part.to_string());
                }
            }
        }
        result
    }
}