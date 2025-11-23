impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn reformat(s: String) -> String {
        let mut letters = VecDeque::new();
        let mut digits = VecDeque::new();

        for c in s.chars() {
            if c.is_ascii_digit() {
                digits.push_back(c);
            } else {
                letters.push_back(c);
            }
        }

        if (letters.len() - digits.len()).abs() > 1 {
            return String::new();
        }

        let mut result = String::new();
        let (mut longer, mut shorter) = if letters.len() > digits.len() {
            (&mut letters, &mut digits)
        } else {
            (&mut digits, &mut letters)
        };

        while !longer.is_empty() || !shorter.is_empty() {
            result.push(longer.pop_front().unwrap());
            if !shorter.is_empty() {
                result.push(shorter.pop_front().unwrap());
            }
        }

        result
    }
}
}