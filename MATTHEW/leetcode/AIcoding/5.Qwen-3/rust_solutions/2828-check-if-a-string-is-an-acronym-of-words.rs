impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn is_acronym(words: Vec<String>, s: String) -> bool {
        if words.len() != s.len() {
            return false;
        }

        for (i, word) in words.iter().enumerate() {
            match word.chars().next() {
                Some(c) if c != s.chars().nth(i).unwrap() => return false,
                _ => {}
            }
        }

        true
    }
}
}