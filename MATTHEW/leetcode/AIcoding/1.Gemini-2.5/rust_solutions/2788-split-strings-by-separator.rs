use std::collections::HashSet;

impl Solution {
    pub fn split_words_by_separator(words: Vec<String>, separators: Vec<char>) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        let separator_set: HashSet<char> = separators.into_iter().collect();

        for word in words {
            word.split(|c: char| separator_set.contains(&c))
                .filter(|s| !s.is_empty())
                .for_each(|s| result.push(s.to_string()));
        }

        result
    }
}