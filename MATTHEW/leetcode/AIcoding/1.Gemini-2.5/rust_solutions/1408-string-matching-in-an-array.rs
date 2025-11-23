use std::collections::HashSet;

impl Solution {
    pub fn string_matching(words: Vec<String>) -> Vec<String> {
        let mut result_set: HashSet<String> = HashSet::new();

        for i in 0..words.len() {
            for j in 0..words.len() {
                if i == j {
                    continue;
                }
                if words[j].contains(&words[i]) {
                    result_set.insert(words[i].clone());
                }
            }
        }

        result_set.into_iter().collect()
    }
}