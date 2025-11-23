struct Solution;

impl Solution {
    pub fn modify_string(s: String) -> String {
        let mut s = s.chars().collect::<Vec<char>>();
        for i in 0..s.len() {
            if s[i] == '?' {
                for c in "abc".chars() {
                    if (i == 0 || s[i - 1] != c) && (i == s.len() - 1 || s[i + 1] != c) {
                        s[i] = c;
                        break;
                    }
                }
            }
        }
        s.into_iter().collect()
    }
}