use std::collections::HashSet;

impl Solution {
    pub fn similar_pairs(words: Vec<String>) -> i32 {
        let mut count = 0;
        for i in 0..words.len() {
            for j in i + 1..words.len() {
                let set1: HashSet<char> = words[i].chars().collect();
                let set2: HashSet<char> = words[j].chars().collect();
                if set1 == set2 {
                    count += 1;
                }
            }
        }
        count
    }
}