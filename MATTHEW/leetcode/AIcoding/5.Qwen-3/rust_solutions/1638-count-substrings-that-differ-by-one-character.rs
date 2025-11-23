struct Solution;

impl Solution {
    pub fn count_substrings(s: String, t: String) -> i32 {
        let m = s.len();
        let n = t.len();
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let mut count = 0;

        for i in 0..m {
            for j in 0..n {
                let mut diff = 0;
                let mut k = 0;
                while i + k < m && j + k < n {
                    if s_bytes[i + k] != t_bytes[j + k] {
                        diff += 1;
                    }
                    if diff == 1 {
                        count += 1;
                    } else if diff > 1 {
                        break;
                    }
                    k += 1;
                }
            }
        }

        count
    }
}