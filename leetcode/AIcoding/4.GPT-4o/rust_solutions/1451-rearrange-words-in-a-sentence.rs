impl Solution {
    pub fn arrange_words(text: String) -> String {
        let mut words: Vec<&str> = text.split_whitespace().collect();
        words.sort_by_key(|w| w.len());
        let mut result = words.join(" ");
        result = result.to_lowercase();
        let first_char = result.chars().next().unwrap().to_uppercase();
        result.replace_range(0..1, &first_char.to_string());
        result
    }
}