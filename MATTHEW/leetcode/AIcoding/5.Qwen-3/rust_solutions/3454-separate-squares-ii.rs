impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn split_word(s: String) -> Vec<String> {
        let mut result = Vec::new();
        let mut seen = HashSet::new();
        let chars: Vec<char> = s.chars().collect();

        for i in 0..chars.len() {
            for j in i+1..chars.len() {
                let left = &chars[..i];
                let right = &chars[j..];
                let middle = &chars[i..j];

                let left_str = left.iter().collect::<String>();
                let middle_str = middle.iter().collect::<String>();
                let right_str = right.iter().collect::<String>();

                if !left_str.is_empty() && !right_str.is_empty() && !middle_str.is_empty() {
                    let key = format!("{}{}", left_str, right_str);
                    if !seen.contains(&key) {
                        result.push(format!("{} {} {}", left_str, middle_str, right_str));
                        seen.insert(key);
                    }
                }
            }
        }

        result.sort();
        result
    }
}
}