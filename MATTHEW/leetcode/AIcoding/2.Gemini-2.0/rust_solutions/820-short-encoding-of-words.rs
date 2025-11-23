impl Solution {
    pub fn minimum_length_encoding(words: Vec<String>) -> i32 {
        let mut sorted_words = words;
        sorted_words.sort_by(|a, b| b.len().cmp(&a.len()));

        let mut result = String::new();
        for word in sorted_words {
            if !result.contains(&(word.clone() + "#")) {
                result.push_str(&word);
                result.push_str("#");
            }
        }

        result.len() as i32
    }
}