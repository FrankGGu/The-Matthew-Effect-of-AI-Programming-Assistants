impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn lex_smallest_string(s: String) -> String {
        let mut s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut i = 0;

        while i < n - 1 {
            if s[i] > s[i + 1] {
                s.remove(i);
                i = 0;
                n = s.len();
            } else {
                i += 1;
            }
        }

        s.into_iter().collect()
    }
}
}