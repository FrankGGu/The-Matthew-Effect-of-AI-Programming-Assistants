use std::collections::HashMap;

impl Solution {
    pub fn smallest_palindrome(s: String) -> String {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut odd_char = None;
        let mut half = Vec::new();
        for c in ('a'..='z').chain(('A'..='Z').chain('0'..='9')) {
            if let Some(&count) = freq.get(&c) {
                if count % 2 != 0 {
                    if odd_char.is_some() {
                        return "".to_string();
                    }
                    odd_char = Some(c);
                }
                for _ in 0..count / 2 {
                    half.push(c);
                }
            }
        }

        half.sort();

        let mut palindrome = String::new();
        for &c in &half {
            palindrome.push(c);
        }

        if let Some(c) = odd_char {
            palindrome.push(c);
        }

        for &c in half.iter().rev() {
            palindrome.push(c);
        }

        palindrome
    }
}