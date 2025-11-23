impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_subsequence_score(s: String, t: String) -> String {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut result = String::new();
        let mut i = 0;
        let mut j = 0;
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();

        while j < t.len() {
            if i < s.len() && s_chars[i] == t_chars[j] {
                result.push(t_chars[j]);
                count.entry(t_chars[j]).and_modify(|e| *e -= 1);
                i += 1;
                j += 1;
            } else {
                result.push(t_chars[j]);
                j += 1;
            }
        }

        result
    }
}
}