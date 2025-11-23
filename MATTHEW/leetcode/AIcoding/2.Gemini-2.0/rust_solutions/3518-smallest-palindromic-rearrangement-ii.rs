impl Solution {
    pub fn make_smallest_palindrome(s: String) -> String {
        let mut counts = std::collections::HashMap::new();
        for c in s.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        let mut odd_chars = Vec::new();
        for (&c, &count) in &counts {
            if count % 2 != 0 {
                odd_chars.push(c);
            }
        }

        if odd_chars.len() > 1 {
            return "".to_string();
        }

        let mut result = String::new();
        let mut chars = Vec::new();
        for (&c, &count) in &counts {
            for _ in 0..count / 2 {
                chars.push(c);
            }
        }

        chars.sort();

        for &c in &chars {
            result.push(c);
        }

        if !odd_chars.is_empty() {
            result.push(odd_chars[0]);
        }

        for &c in chars.iter().rev() {
            result.push(c);
        }

        result
    }
}