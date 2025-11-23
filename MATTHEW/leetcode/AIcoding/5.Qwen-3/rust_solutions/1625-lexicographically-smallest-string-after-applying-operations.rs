impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn lex_smallest_string(s: String) -> String {
        let mut s: Vec<char> = s.chars().collect();
        let n = s.len();

        for i in 0..n {
            if i % 2 == 0 {
                let mut min_char = s[i];
                let mut min_idx = i;
                for j in (i + 1)..n {
                    if j % 2 == 0 && s[j] < min_char {
                        min_char = s[j];
                        min_idx = j;
                    }
                }
                if min_idx != i {
                    s.swap(i, min_idx);
                }
            } else {
                let mut min_char = s[i];
                let mut min_idx = i;
                for j in (i + 1)..n {
                    if j % 2 == 1 && s[j] < min_char {
                        min_char = s[j];
                        min_idx = j;
                    }
                }
                if min_idx != i {
                    s.swap(i, min_idx);
                }
            }
        }

        s.into_iter().collect()
    }
}
}