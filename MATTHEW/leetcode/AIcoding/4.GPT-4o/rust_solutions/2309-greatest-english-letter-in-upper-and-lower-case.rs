impl Solution {
    pub fn greatest_letter(s: String) -> String {
        let mut seen = [false; 26];
        for c in s.chars() {
            if c.is_ascii_uppercase() {
                seen[(c as u8 - b'A') as usize] = true;
            } else if c.is_ascii_lowercase() {
                seen[(c as u8 - b'a') as usize] = true;
            }
        }
        for i in (0..26).rev() {
            if seen[i] && seen[i + 32] {
                return (b'A' + i as u8) as char).to_string();
            }
        }
        String::new()
    }
}