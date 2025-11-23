impl Solution {

use std::vec::Vec;

struct Solution {}

impl Solution {
    pub fn restore_ip_addresses(s: String) -> Vec<String> {
        let mut result = Vec::new();
        let mut current = Vec::new();
        Self::backtrack(&s, 0, &mut current, &mut result);
        result
    }

    fn backtrack(s: &str, start: usize, current: &mut Vec<&str>, result: &mut Vec<String>) {
        if current.len() == 4 {
            if start == s.len() {
                let ip = current.join(".");
                result.push(ip);
            }
            return;
        }

        for end in start + 1..=s.len() {
            let part = &s[start..end];
            if part.len() > 1 && part.starts_with('0') {
                continue;
            }
            if part.parse::<u8>().is_ok() {
                current.push(part);
                Self::backtrack(s, end, current, result);
                current.pop();
            }
        }
    }
}
}