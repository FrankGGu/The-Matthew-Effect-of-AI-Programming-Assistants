impl Solution {
    pub fn capitalize_title(title: String) -> String {
        title.split_whitespace()
            .map(|word| {
                if word.len() > 2 {
                    word[..1].to_uppercase() + &word[1..].to_lowercase()
                } else {
                    word.to_lowercase()
                }
            })
            .collect::<Vec<String>>()
            .join(" ")
    }
}