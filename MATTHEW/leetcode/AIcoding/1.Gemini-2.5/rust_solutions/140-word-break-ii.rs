use std::collections::{HashSet, HashMap};

pub struct Solution;

impl Solution {
    pub fn word_break(s: String, word_dict: Vec<String>) -> Vec<String> {
        let word_set: HashSet<String> = word_dict.into_iter().collect();
        let mut memo: HashMap<usize, Vec<String>> = HashMap::new();

        Self::backtrack(0, &s, &word_set, &mut memo)
    }

    fn backtrack(
        start_index: usize,
        s: &str,
        word_set: &HashSet<String>,
        memo: &mut HashMap<usize, Vec<String>>,
    ) -> Vec<String> {
        if let Some(res) = memo.get(&start_index) {
            return res.clone();
        }

        if start_index == s.len() {
            return vec!["".to_string()];
        }

        let mut results: Vec<String> = Vec::new();

        for i in start_index..s.len() {
            let word = &s[start_index..=i];
            if word_set.contains(word) {
                let suffixes = Self::backtrack(i + 1, s, word_set, memo);
                for suffix in suffixes {
                    if suffix.is_empty() {
                        results.push(word.to_string());
                    } else {
                        results.push(format!("{} {}", word, suffix));
                    }
                }
            }
        }

        memo.insert(start_index, results.clone());
        results
    }
}