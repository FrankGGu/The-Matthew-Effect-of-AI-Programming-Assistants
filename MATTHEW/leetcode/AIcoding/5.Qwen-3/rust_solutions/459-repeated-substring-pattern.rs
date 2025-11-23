impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn repeated_substring_pattern(s: String) -> bool {
        let s_len = s.len();
        for i in 1..=s_len / 2 {
            if s_len % i != 0 {
                continue;
            }
            let substr = &s[0..i];
            let mut is_valid = true;
            for j in 1..s_len / i {
                let start = j * i;
                let end = start + i;
                if &s[start..end] != substr {
                    is_valid = false;
                    break;
                }
            }
            if is_valid {
                return true;
            }
        }
        false
    }
}
}