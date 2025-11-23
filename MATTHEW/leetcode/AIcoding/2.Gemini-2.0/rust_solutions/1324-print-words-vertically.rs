impl Solution {
    pub fn print_vertically(s: String) -> Vec<String> {
        let words: Vec<&str> = s.split_whitespace().collect();
        let mut max_len = 0;
        for word in &words {
            max_len = max_len.max(word.len());
        }

        let mut result: Vec<String> = Vec::new();
        for i in 0..max_len {
            let mut vertical_word = String::new();
            for word in &words {
                if i < word.len() {
                    vertical_word.push(word.chars().nth(i).unwrap());
                } else {
                    vertical_word.push(' ');
                }
            }

            while vertical_word.ends_with(' ') {
                vertical_word.pop();
            }

            result.push(vertical_word);
        }

        result
    }
}