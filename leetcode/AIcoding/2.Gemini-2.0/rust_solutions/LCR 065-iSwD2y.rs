impl Solution {
    pub fn minimum_length_encoding(words: Vec<String>) -> i32 {
        let mut sorted_words = words;
        sorted_words.sort_by(|a, b| b.len().cmp(&a.len()));

        let mut s = String::new();
        for word in sorted_words {
            if !s.contains(&(word.clone() + "#")) {
                s.push_str(&word);
                s.push_str("#");
            }
        }

        s.len() as i32
    }
}