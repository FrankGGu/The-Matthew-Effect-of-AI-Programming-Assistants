impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn num_of_strings(patterns: Vec<String>, word: String) -> i32 {
        let mut set = HashSet::new();
        for i in 0..word.len() {
            for j in i+1..=word.len() {
                set.insert(&word[i..j]);
            }
        }
        let mut count = 0;
        for p in patterns {
            if set.contains(p.as_str()) {
                count += 1;
            }
        }
        count
    }
}
}