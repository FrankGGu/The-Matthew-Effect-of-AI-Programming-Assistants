use std::collections::HashMap;

struct SuffixArray {
    suffixes: Vec<String>,
}

impl SuffixArray {
    fn new(words: Vec<String>) -> Self {
        let mut suffixes = Vec::new();
        for word in words.iter() {
            for i in 0..word.len() {
                suffixes.push(word[i..].to_string());
            }
        }
        suffixes.sort();
        SuffixArray { suffixes }
    }

    fn longest_common_suffix(&self, query: &str) -> String {
        let mut longest = String::new();
        for suffix in &self.suffixes {
            if suffix.ends_with(query) {
                if query.len() > longest.len() {
                    longest = query.to_string();
                }
            }
        }
        longest
    }
}

struct Solution;

impl Solution {
    pub fn longest_common_suffix(words: Vec<String>, queries: Vec<String>) -> Vec<String> {
        let suffix_array = SuffixArray::new(words);
        queries.into_iter().map(|query| suffix_array.longest_common_suffix(&query)).collect()
    }
}