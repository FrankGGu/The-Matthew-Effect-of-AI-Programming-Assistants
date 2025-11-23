use std::collections::HashSet;

impl Solution {
    pub fn minimum_length_encoding(words: Vec<String>) -> i32 {
        let mut set: HashSet<String> = words.into_iter().collect();
        for word in set.clone().iter() {
            for i in 1..word.len() {
                set.remove(&word[i..].to_string());
            }
        }
        set.iter().map(|word| word.len() as i32 + 1).sum()
    }
}