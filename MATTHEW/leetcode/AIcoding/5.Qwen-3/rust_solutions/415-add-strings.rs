impl Solution {

use std::iter;

impl Solution {
    pub fn add_strings(num1: String, num2: String) -> String {
        let mut i = num1.len() as i32 - 1;
        let mut j = num2.len() as i32 - 1;
        let mut carry = 0;
        let mut result = Vec::new();

        while i >= 0 || j >= 0 || carry > 0 {
            let mut sum = carry;
            if i >= 0 {
                sum += (num1.as_bytes()[i as usize] - b'0') as i32;
            }
            if j >= 0 {
                sum += (num2.as_bytes()[j as usize] - b'0') as i32;
            }
            carry = sum / 10;
            result.push((sum % 10 + b'0') as char);
            i -= 1;
            j -= 1;
        }

        result.into_iter().rev().collect()
    }
}

struct Solution;
}