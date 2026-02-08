use std::collections::HashSet;

impl Solution {
    pub fn longest_valid_substring(word: String, forbidden: Vec<String>) -> i32 {
        let forbidden: HashSet<String> = forbidden.into_iter().collect();
        let word_chars: Vec<char> = word.chars().collect();
        let n = word_chars.len();
        let mut max_len = 0;
        let mut left = 0;

        for right in 0..n {
            for i in (left..=right).rev().take(10) {
                let substring: String = word_chars[i..=right].iter().collect();
                if forbidden.contains(&substring) {
                    left = i + 1;
                    break;
                }
            }
            max_len = max_len.max(right - left + 1);
        }

        max_len as i32
    }
}