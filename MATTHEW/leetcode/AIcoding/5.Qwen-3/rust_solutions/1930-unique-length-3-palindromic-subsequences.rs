impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_palindromic_subseqs(s: String) -> i32 {
        let s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut set = HashSet::new();

        for i in 0..n {
            for j in i+1..n {
                for k in j+1..n {
                    if s[i] == s[k] {
                        set.insert((s[i], s[j], s[k]));
                    }
                }
            }
        }

        set.len() as i32
    }
}
}