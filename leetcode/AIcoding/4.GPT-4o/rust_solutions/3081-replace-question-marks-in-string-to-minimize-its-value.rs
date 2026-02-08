impl Solution {
    pub fn modify_string(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        for i in 0..n {
            if chars[i] == '?' {
                let mut replacement = 'a';
                while (i > 0 && chars[i - 1] == replacement) || (i < n - 1 && chars[i + 1] == replacement) {
                    replacement = ((replacement as u8) + 1) as char;
                }
                chars[i] = replacement;
            }
        }
        chars.into_iter().collect()
    }
}