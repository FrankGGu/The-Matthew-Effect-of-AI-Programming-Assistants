impl Solution {
    pub fn find_encrypted_string(s: String, shift: i32) -> String {
        let mut result = String::new();
        for c in s.chars() {
            if c.is_ascii_alphabetic() {
                let base = if c.is_ascii_lowercase() { 'a' as u8 } else { 'A' as u8 };
                let shifted_char = (((c as u8 - base + shift as u8) % 26) + base) as char;
                result.push(shifted_char);
            } else {
                result.push(c);
            }
        }
        result
    }
}