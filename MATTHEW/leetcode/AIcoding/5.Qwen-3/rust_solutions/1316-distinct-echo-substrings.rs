struct Solution;

impl Solution {
    pub fn echo_substrings(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut result = 0;
        let mut seen = std::collections::HashSet::new();

        for i in 0..n {
            for j in i + 1..n {
                let len = j - i;
                if j + len <= n && s_bytes[i..i + len] == s_bytes[j..j + len] {
                    let substr = &s[i..j];
                    if !seen.contains(substr) {
                        seen.insert(substr.to_string());
                        result += 1;
                    }
                }
            }
        }

        result
    }
}