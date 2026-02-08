impl Solution {
    pub fn greatest_letter(s: String) -> String {
        let mut lowercase = [false; 26];
        let mut uppercase = [false; 26];

        for c in s.chars() {
            if c.is_ascii_lowercase() {
                lowercase[(c as u8 - b'a') as usize] = true;
            } else if c.is_ascii_uppercase() {
                uppercase[(c as u8 - b'A') as usize] = true;
            }
        }

        for i in (0..26).rev() {
            if lowercase[i] && uppercase[i] {
                return ((i as u8) + b'A') as char).to_string();
            }
        }

        "".to_string()
    }
}