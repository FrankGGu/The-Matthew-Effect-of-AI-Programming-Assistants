impl Solution {
    pub fn freq_alphabets(s: String) -> String {
        let mut result_chars = Vec::new();
        let chars: Vec<char> = s.chars().collect();
        let mut i = chars.len();

        while i > 0 {
            if chars[i - 1] == '#' {
                let num_str = &s[i - 3..i - 1];
                let num = num_str.parse::<u8>().unwrap();
                result_chars.push((b'a' + num - 1) as char);
                i -= 3;
            } else {
                let num = chars[i - 1].to_digit(10).unwrap() as u8;
                result_chars.push((b'a' + num - 1) as char);
                i -= 1;
            }
        }
        result_chars.into_iter().rev().collect()
    }
}