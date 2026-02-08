impl Solution {
    pub fn arrange_words(text: String) -> String {
        let mut words: Vec<String> = text.split_whitespace().map(|s| s.to_string()).collect();
        words[0] = words[0].to_lowercase();

        words.sort_by_key(|word| word.len());

        let mut result = words.join(" ");
        let mut chars: Vec<char> = result.chars().collect();
        if !chars.is_empty() {
            chars[0] = chars[0].to_uppercase().next().unwrap();
        }
        result = chars.into_iter().collect();

        result
    }
}