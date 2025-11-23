use std::collections::HashSet;

pub struct Solution;

impl Solution {
    pub fn distinct_echo_substrings(text: String) -> i32 {
        let n = text.len();
        let bytes = text.as_bytes();
        let mut seen = HashSet::new();

        for len in 1..=n / 2 {
            let mut seen_substrings = HashSet::new();
            for i in 0..=n - 2 * len {
                if bytes[i..i + len] == bytes[i + len..i + 2 * len] {
                    seen_substrings.insert(&text[i..i + len]);
                }
            }
            seen.extend(seen_substrings);
        }

        seen.len() as i32
    }
}