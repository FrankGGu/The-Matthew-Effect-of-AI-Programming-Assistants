use std::collections::HashSet;

impl Solution {
    pub fn replace_words(dictionary: Vec<String>, sentence: String) -> String {
        let dict: HashSet<String> = dictionary.into_iter().collect();
        let words: Vec<&str> = sentence.split_whitespace().collect();
        let mut result = Vec::new();

        for word in words {
            let mut prefix = String::new();
            let mut found = false;
            for c in word.chars() {
                prefix.push(c);
                if dict.contains(&prefix) {
                    result.push(prefix);
                    found = true;
                    break;
                }
            }
            if !found {
                result.push(word.to_string());
            }
        }

        result.join(" ")
    }
}