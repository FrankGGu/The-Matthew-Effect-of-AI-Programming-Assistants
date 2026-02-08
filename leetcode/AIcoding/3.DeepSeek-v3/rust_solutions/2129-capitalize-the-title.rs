impl Solution {
    pub fn capitalize_title(title: String) -> String {
        title
            .split_whitespace()
            .map(|word| {
                if word.len() <= 2 {
                    word.to_lowercase()
                } else {
                    let mut chars = word.chars();
                    let first = chars.next().unwrap().to_uppercase().to_string();
                    let rest: String = chars.collect::<String>().to_lowercase();
                    first + &rest
                }
            })
            .collect::<Vec<_>>()
            .join(" ")
    }
}