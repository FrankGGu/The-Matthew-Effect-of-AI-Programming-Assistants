impl Solution {
    pub fn capitalize_title(title: String) -> String {
        title
            .split_whitespace()
            .map(|word| {
                if word.len() <= 2 {
                    word.to_ascii_lowercase()
                } else {
                    let mut chars = word.chars();
                    let first_char = chars.next().unwrap().to_ascii_uppercase();
                    let rest_of_word: String = chars.map(|c| c.to_ascii_lowercase()).collect();
                    format!("{}{}", first_char, rest_of_word)
                }
            })
            .collect::<Vec<String>>()
            .join(" ")
    }
}