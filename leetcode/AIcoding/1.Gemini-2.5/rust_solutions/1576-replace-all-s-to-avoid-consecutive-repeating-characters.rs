impl Solution {
    pub fn replace_chars(s: String) -> String {
        let mut s_chars: Vec<char> = s.chars().collect();
        let n = s_chars.len();

        for i in 0..n {
            if s_chars[i] == '?' {
                for &c in &['a', 'b', 'c'] {
                    let mut is_valid = true;

                    // Check left neighbor
                    if i > 0 && s_chars[i - 1] == c {
                        is_valid = false;
                    }

                    // Check right neighbor
                    if is_valid && i < n - 1 && s_chars[i + 1] == c {
                        is_valid = false;
                    }

                    if is_valid {
                        s_chars[i] = c;
                        break;
                    }
                }
            }
        }

        s_chars.into_iter().collect()
    }
}