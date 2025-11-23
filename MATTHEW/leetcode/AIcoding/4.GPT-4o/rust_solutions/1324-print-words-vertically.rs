pub fn print_vertically(s: String) -> Vec<String> {
    let words: Vec<&str> = s.split_whitespace().collect();
    let max_len = words.iter().map(|word| word.len()).max().unwrap_or(0);
    let mut result = Vec::new();

    for i in 0..max_len {
        let mut vertical_word = String::new();
        for word in &words {
            if i < word.len() {
                vertical_word.push(word.chars().nth(i).unwrap());
            } else if !vertical_word.is_empty() {
                vertical_word.push(' ');
            }
        }
        result.push(vertical_word.trim_end().to_string());
    }

    result
}