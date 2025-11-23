impl Solution {
    pub fn replace_digits(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        for i in (1..chars.len()).step_by(2) {
            let prev_char = chars[i - 1];
            let digit = chars[i].to_digit(10).unwrap() as u8;
            chars[i] = ((prev_char as u8) + digit) as char;
        }
        chars.into_iter().collect()
    }
}