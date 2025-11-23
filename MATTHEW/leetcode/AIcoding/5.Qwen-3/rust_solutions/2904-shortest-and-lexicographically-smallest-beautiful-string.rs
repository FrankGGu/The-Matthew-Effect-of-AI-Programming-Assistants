impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn shortest_beautiful_string(s: String) -> String {
        let mut s = s.chars().collect::<Vec<char>>();
        let n = s.len();

        for i in (0..n).rev() {
            let mut c = s[i];
            let mut next_char = None;

            for j in (c as u8 + 1)..='z' as u8 {
                let ch = (j as char);
                if i > 0 && s[i - 1] == ch {
                    continue;
                }
                if i < n - 1 && s[i + 1] == ch {
                    continue;
                }
                next_char = Some(ch);
                break;
            }

            if let Some(ch) = next_char {
                s[i] = ch;
                for j in (i + 1)..n {
                    for k in 'a' as u8..='z' as u8 {
                        let ch = (k as char);
                        if j > 0 && s[j - 1] == ch {
                            continue;
                        }
                        if j < n - 1 && s[j + 1] == ch {
                            continue;
                        }
                        s[j] = ch;
                        break;
                    }
                }
                return s.iter().collect();
            }
        }

        String::new()
    }
}
}