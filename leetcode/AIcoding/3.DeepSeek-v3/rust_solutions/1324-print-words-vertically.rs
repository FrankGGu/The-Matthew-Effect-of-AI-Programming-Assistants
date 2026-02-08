impl Solution {
    pub fn print_vertically(s: String) -> Vec<String> {
        let words: Vec<&str> = s.split_whitespace().collect();
        let max_len = words.iter().map(|word| word.len()).max().unwrap_or(0);
        let mut result = vec![String::new(); max_len];

        for i in 0..max_len {
            for word in &words {
                if i < word.len() {
                    result[i].push(word.chars().nth(i).unwrap());
                } else {
                    result[i].push(' ');
                }
            }
            result[i] = result[i].trim_end().to_string();
        }

        result
    }
}