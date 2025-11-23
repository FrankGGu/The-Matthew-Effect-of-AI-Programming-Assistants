impl Solution {
    pub fn replace_digits(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        for i in 1..chars.len() {
            if i % 2 != 0 {
                let shift = chars[i].to_digit(10).unwrap() as u8;
                chars[i] = (chars[i - 1] as u8 + shift) as char;
            }
        }
        chars.into_iter().collect()
    }
}