impl Solution {
    pub fn modify_string(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        for i in 0..n {
            if chars[i] == '?' {
                for c in 'a'..='c' {
                    let prev = if i > 0 { chars[i - 1] } else { ' ' };
                    let next = if i < n - 1 { chars[i + 1] } else { ' ' };

                    if c != prev && c != next {
                        chars[i] = c;
                        break;
                    }
                }
            }
        }

        chars.into_iter().collect()
    }
}