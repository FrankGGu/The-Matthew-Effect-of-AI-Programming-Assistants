use std::collections::HashSet;

impl Solution {
    pub fn count_palindromic_subsequence(s: String) -> i32 {
        let s = s.as_bytes();
        let mut first = vec![usize::MAX; 26];
        let mut last = vec![usize::MIN; 26];

        for (i, &c) in s.iter().enumerate() {
            let idx = (c - b'a') as usize;
            if first[idx] == usize::MAX {
                first[idx] = i;
            }
            last[idx] = i;
        }

        let mut res = 0;
        for i in 0..26 {
            if first[i] != usize::MAX && last[i] != usize::MIN && first[i] < last[i] {
                let mut unique = HashSet::new();
                for j in first[i] + 1..last[i] {
                    unique.insert(s[j]);
                }
                res += unique.len() as i32;
            }
        }
        res
    }
}