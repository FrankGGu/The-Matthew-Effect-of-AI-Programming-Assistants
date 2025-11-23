use std::collections::HashSet;

impl Solution {
    pub fn replace_words(dictionary: Vec<String>, sentence: String) -> String {
        let dict: HashSet<String> = dictionary.into_iter().collect();
        sentence
            .split_whitespace()
            .map(|word| {
                for i in 1..=word.len() {
                    let prefix = &word[0..i];
                    if dict.contains(prefix) {
                        return prefix.to_string();
                    }
                }
                word.to_string()
            })
            .collect::<Vec<String>>()
            .join(" ")
    }
}