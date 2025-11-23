use std::collections::HashSet;

impl Solution {
    pub fn replace_words(dictionary: Vec<String>, sentence: String) -> String {
        let dict: HashSet<String> = dictionary.into_iter().collect();
        let words: Vec<&str> = sentence.split_whitespace().collect();
        let mut res = Vec::new();

        for word in words {
            let mut found = false;
            for i in 1..=word.len() {
                let prefix = &word[..i];
                if dict.contains(prefix) {
                    res.push(prefix.to_string());
                    found = true;
                    break;
                }
            }
            if !found {
                res.push(word.to_string());
            }
        }

        res.join(" ")
    }
}