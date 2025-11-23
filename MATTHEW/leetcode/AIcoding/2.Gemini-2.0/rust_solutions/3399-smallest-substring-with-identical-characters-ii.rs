use std::collections::HashMap;

impl Solution {
    pub fn smallest_substring(s: String, k: i32) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut min_len = -1;

        for i in 0..n {
            for j in i..n {
                let mut counts: HashMap<u8, i32> = HashMap::new();
                for l in i..=j {
                    *counts.entry(s_bytes[l]).or_insert(0) += 1;
                }

                let mut valid = false;
                for &count in counts.values() {
                    if count >= k {
                        valid = true;
                        break;
                    }
                }

                if valid {
                    let len = (j - i + 1) as i32;
                    if min_len == -1 || len < min_len {
                        min_len = len;
                    }
                }
            }
        }

        min_len
    }
}