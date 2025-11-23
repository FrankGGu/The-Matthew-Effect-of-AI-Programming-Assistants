impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn special_substrings(s: String, k: i32) -> i32 {
        let k = k as usize;
        let mut set = HashSet::new();
        let s_bytes = s.as_bytes();
        let n = s.len();

        for i in 0..n - k + 1 {
            let end = i + k;
            let substr = &s_bytes[i..end];
            let mut unique = true;
            for j in 0..k - 1 {
                if substr[j] == substr[j + 1] {
                    unique = false;
                    break;
                }
            }
            if unique {
                set.insert(substr);
            }
        }

        set.len() as i32
    }
}
}