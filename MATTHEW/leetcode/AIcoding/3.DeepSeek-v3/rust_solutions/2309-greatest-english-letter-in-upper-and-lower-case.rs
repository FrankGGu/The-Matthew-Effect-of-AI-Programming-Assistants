impl Solution {
    pub fn greatest_letter(s: String) -> String {
        let mut upper = [false; 26];
        let mut lower = [false; 26];

        for c in s.chars() {
            if c.is_ascii_uppercase() {
                upper[(c as u8 - b'A') as usize] = true;
            } else if c.is_ascii_lowercase() {
                lower[(c as u8 - b'a') as usize] = true;
            }
        }

        for i in (0..26).rev() {
            if upper[i] && lower[i] {
                return ((b'A' + i as u8) as char).to_string();
            }
        }

        "".to_string()
    }
}