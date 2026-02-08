impl Solution {
    pub fn replace_digits(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        for i in (1..chars.len()).step_by(2) {
            let prev = chars[i - 1] as u8;
            let shift = chars[i] as u8 - b'0';
            chars[i] = (prev + shift) as char;
        }
        chars.into_iter().collect()
    }
}