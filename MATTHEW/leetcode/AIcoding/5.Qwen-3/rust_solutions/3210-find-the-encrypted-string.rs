struct Solution;

impl Solution {
    pub fn encrypt_string(s: String, k: i32) -> String {
        let k = k as usize;
        let mut result = String::with_capacity(s.len());
        for (i, c) in s.chars().enumerate() {
            let shifted = ((c as u8 - b'a' + k as u8) % 26) + b'a';
            result.push(shifted as char);
        }
        result
    }
}