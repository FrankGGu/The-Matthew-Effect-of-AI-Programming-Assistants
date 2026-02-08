impl Solution {
    pub fn arrange_words(text: String) -> String {
        let mut words: Vec<_> = text.split_whitespace().collect();
        if words.is_empty() {
            return String::new();
        }
        words[0] = &words[0].to_lowercase();
        words.sort_by_key(|word| word.len());
        let mut result = words.join(" ");
        if !result.is_empty() {
            result[0..1].make_ascii_uppercase();
        }
        result
    }
}