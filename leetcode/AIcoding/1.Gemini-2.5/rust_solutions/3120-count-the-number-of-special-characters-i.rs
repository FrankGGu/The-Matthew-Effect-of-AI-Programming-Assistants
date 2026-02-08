impl Solution {
    pub fn number_of_special_chars(s: String) -> i32 {
        let mut seen_lower = [false; 26];
        let mut seen_upper = [false; 26];

        for c in s.chars() {
            if c.is_ascii_lowercase() {
                seen_lower[(c as u8 - b'a') as usize] = true;
            } else if c.is_ascii_uppercase() {
                seen_upper[(c as u8 - b'A') as usize] = true;
            }
        }

        let mut count = 0;
        for i in 0..26 {
            if seen_lower[i] && seen_upper[i] {
                count += 1;
            }
        }

        count
    }
}