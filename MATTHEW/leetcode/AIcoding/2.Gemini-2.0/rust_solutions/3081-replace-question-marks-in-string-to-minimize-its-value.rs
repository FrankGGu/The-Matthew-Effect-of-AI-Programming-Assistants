impl Solution {
    pub fn modify_string(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        for i in 0..n {
            if chars[i] == '?' {
                for c in ['a', 'b', 'c'].iter() {
                    let mut valid = true;
                    if i > 0 && chars[i - 1] == *c {
                        valid = false;
                    }
                    if i < n - 1 && chars[i + 1] != '?' && chars[i + 1] == *c {
                        valid = false;
                    }

                    if valid {
                        chars[i] = *c;
                        break;
                    }
                }
            }
        }

        chars.into_iter().collect()
    }
}