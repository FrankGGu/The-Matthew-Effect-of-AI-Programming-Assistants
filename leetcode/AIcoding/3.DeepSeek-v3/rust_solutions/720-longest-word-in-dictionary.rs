use std::collections::HashSet;

impl Solution {
    pub fn longest_word(words: Vec<String>) -> String {
        let mut word_set: HashSet<String> = words.iter().cloned().collect();
        let mut longest = String::new();

        for word in words {
            let mut valid = true;
            for i in 1..word.len() {
                if !word_set.contains(&word[..i].to_string()) {
                    valid = false;
                    break;
                }
            }
            if valid {
                if word.len() > longest.len() || (word.len() == longest.len() && word < longest) {
                    longest = word;
                }
            }
        }

        longest
    }
}