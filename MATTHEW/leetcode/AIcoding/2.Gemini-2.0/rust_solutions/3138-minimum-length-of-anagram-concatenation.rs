use std::collections::HashMap;

impl Solution {
    pub fn min_length(s: String, t: String) -> i32 {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let n = s_bytes.len();
        let m = t_bytes.len();

        let mut t_freq: HashMap<u8, i32> = HashMap::new();
        for &b in t_bytes {
            *t_freq.entry(b).or_insert(0) += 1;
        }

        let mut min_len = i32::MAX;
        for len in 1..=n {
            for i in 0..=n - len {
                let mut sub_freq: HashMap<u8, i32> = HashMap::new();
                for j in i..i + len {
                    *sub_freq.entry(s_bytes[j]).or_insert(0) += 1;
                }

                if sub_freq == t_freq {
                    min_len = min_len.min(len as i32);
                }
            }
        }

        if min_len == i32::MAX {
            -1
        } else {
            min_len
        }
    }
}