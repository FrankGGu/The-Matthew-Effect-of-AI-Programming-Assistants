impl Solution {
    pub fn modify_string(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        for i in 0..chars.len() {
            if chars[i] == '?' {
                for c in 'a'..='z' {
                    if (i == 0 || c != chars[i - 1]) && (i == chars.len() - 1 || c != chars[i + 1]) {
                        chars[i] = c;
                        break;
                    }
                }
            }
        }
        chars.into_iter().collect()
    }
}