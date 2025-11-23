impl Solution {
    pub fn number_of_special_chars(word: String) -> i32 {
        let mut lower = [false; 26];
        let mut upper = [false; 26];
        for c in word.chars() {
            if c.is_ascii_lowercase() {
                lower[(c as u8 - b'a') as usize] = true;
            } else if c.is_ascii_uppercase() {
                upper[(c as u8 - b'A') as usize] = true;
            }
        }
        lower.iter().zip(upper.iter()).filter(|(l, u)| **l && **u).count() as i32
    }
}