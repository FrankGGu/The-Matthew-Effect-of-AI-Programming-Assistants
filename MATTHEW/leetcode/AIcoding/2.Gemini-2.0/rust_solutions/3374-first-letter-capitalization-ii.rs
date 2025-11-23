impl Solution {
    pub fn capitalize_title(title: String) -> String {
        title
            .split_whitespace()
            .map(|word| {
                if word.len() <= 2 {
                    word.to_lowercase()
                } else {
                    let mut s = String::new();
                    for (i, c) in word.chars().enumerate() {
                        if i == 0 {
                            s.push(c.to_uppercase().next().unwrap());
                        } else {
                            s.push(c.to_lowercase().next().unwrap());
                        }
                    }
                    s
                }
            })
            .collect::<Vec<String>>()
            .join(" ")
    }
}