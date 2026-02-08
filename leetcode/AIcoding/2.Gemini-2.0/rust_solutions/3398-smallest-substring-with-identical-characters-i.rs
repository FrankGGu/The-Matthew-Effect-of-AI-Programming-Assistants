impl Solution {
    pub fn smallest_substring(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut min_len = -1;

        for i in 0..n {
            for j in i + 1..=n {
                let sub = &s_bytes[i..j];
                if sub.is_empty() {
                    continue;
                }
                let first = sub[0];
                let mut all_same = true;
                for &c in sub {
                    if c != first {
                        all_same = false;
                        break;
                    }
                }

                if all_same {
                    let len = sub.len() as i32;
                    if min_len == -1 || len < min_len {
                        min_len = len;
                    }
                }
            }
        }

        min_len
    }
}