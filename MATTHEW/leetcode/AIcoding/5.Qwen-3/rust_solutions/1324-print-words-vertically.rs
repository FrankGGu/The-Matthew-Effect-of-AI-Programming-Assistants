impl Solution {
    pub fn print_words_vertically(s: String) -> Vec<String> {
        let words: Vec<&str> = s.split_whitespace().collect();
        if words.is_empty() {
            return vec![];
        }

        let max_len = words.iter().map(|w| w.len()).max().unwrap();
        let mut result = Vec::with_capacity(max_len);

        for i in 0..max_len {
            let mut vertical_word = String::new();
            for word in &words {
                if i < word.len() {
                    vertical_word.push(word.chars().nth(i).unwrap());
                } else {
                    vertical_word.push(' ');
                }
            }
            // Trim trailing spaces
            while vertical_word.ends_with(' ') {
                vertical_word.pop();
            }
            result.push(vertical_word);
        }

        result
    }
}