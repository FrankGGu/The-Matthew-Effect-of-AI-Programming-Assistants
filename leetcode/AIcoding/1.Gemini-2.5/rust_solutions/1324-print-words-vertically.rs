impl Solution {
    pub fn print_words_vertically(s: String) -> Vec<String> {
        let words: Vec<&str> = s.split_whitespace().collect();
        let mut max_len = 0;
        for &word in &words {
            if word.len() > max_len {
                max_len = word.len();
            }
        }

        let mut result: Vec<String> = vec![String::new(); max_len];

        for i in 0..max_len {
            for &word in &words {
                if i < word.len() {
                    result[i].push(word.chars().nth(i).unwrap());
                } else {
                    result[i].push(' ');
                }
            }
        }

        result.into_iter().map(|s| s.trim_end().to_string()).collect()
    }
}