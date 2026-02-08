use std::collections::HashMap;

impl Solution {
    pub fn maximum_length(s: String) -> i32 {
        let s = s.as_bytes();
        let mut freq = HashMap::new();
        let mut max_len = -1;

        for i in 0..s.len() {
            let mut j = i;
            while j < s.len() && s[j] == s[i] {
                j += 1;
            }
            let len = j - i;
            for l in 1..=len {
                let entry = freq.entry((s[i], l)).or_insert(0);
                *entry += 1;
                if *entry >= 3 {
                    max_len = max_len.max(l as i32);
                }
            }
            i = j - 1;
        }

        max_len
    }
}