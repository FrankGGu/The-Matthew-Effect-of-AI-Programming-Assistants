impl Solution {

use std::iter;

impl Solution {
    pub fn shifting_letters(s: String, shifts: Vec<i32>) -> String {
        let mut result = vec![];
        let mut shift = 0;

        for i in (0..s.len()).rev() {
            shift = (shift + shifts[i]) % 26;
            let c = ((s.as_bytes()[i] as u8 - b'a' + shift) % 26 + b'a') as char;
            result.push(c);
        }

        result.into_iter().rev().collect()
    }
}
}