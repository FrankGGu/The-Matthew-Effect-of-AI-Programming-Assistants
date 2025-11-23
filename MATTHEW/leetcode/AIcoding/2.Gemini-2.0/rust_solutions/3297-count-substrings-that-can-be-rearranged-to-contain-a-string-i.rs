impl Solution {
    pub fn count_substrings(s: String, t: String) -> i32 {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let n = s_bytes.len();
        let m = t_bytes.len();
        let mut count = 0;

        for i in 0..n {
            for j in i..n {
                let sub = &s_bytes[i..=j];
                let sub_str = String::from_utf8_lossy(sub).to_string();
                if Self::can_rearrange(sub_str, t.clone()) {
                    count += 1;
                }
            }
        }

        count
    }

    fn can_rearrange(sub: String, t: String) -> bool {
        let sub_len = sub.len();
        let t_len = t.len();

        if sub_len < t_len {
            return false;
        }

        let mut t_counts = std::collections::HashMap::new();
        for &b in t.as_bytes() {
            *t_counts.entry(b).or_insert(0) += 1;
        }

        let mut sub_counts = std::collections::HashMap::new();
        for &b in sub.as_bytes() {
            *sub_counts.entry(b).or_insert(0) += 1;
        }

        for (&byte, &count) in &t_counts {
            if sub_counts.get(&byte).map_or(0, |&c| c) < count {
                return false;
            }
        }

        true
    }
}