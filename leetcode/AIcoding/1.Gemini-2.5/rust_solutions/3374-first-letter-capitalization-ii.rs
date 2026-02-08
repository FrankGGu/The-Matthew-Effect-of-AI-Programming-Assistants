impl Solution {
    pub fn capitalize_title(s: String) -> String {
        s.split_ascii_whitespace()
            .map(|word| {
                if word.len() <= 2 {
                    word.to_ascii_lowercase()
                } else {
                    let mut result_word = String::with_capacity(word.len());
                    let mut chars = word.chars();
                    if let Some(first_char) = chars.next() {
                        result_word.push(first_char.to_ascii_uppercase());
                    }
                    for c in chars {
                        result_word.push(c.to_ascii_lowercase());
                    }
                    result_word
                }
            })
            .collect::<Vec<String>>()
            .join(" ")
    }
}