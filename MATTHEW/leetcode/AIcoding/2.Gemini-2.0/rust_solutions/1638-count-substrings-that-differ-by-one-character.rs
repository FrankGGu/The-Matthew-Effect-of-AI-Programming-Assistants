impl Solution {
    pub fn count_substrings(s: String, t: String) -> i32 {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let n = s_bytes.len();
        let m = t_bytes.len();
        let mut count = 0;

        for i in 0..n {
            for j in 0..m {
                let mut diff = 0;
                for k in 0..std::cmp::min(n - i, m - j) {
                    if s_bytes[i + k] != t_bytes[j + k] {
                        diff += 1;
                    }
                    if diff > 1 {
                        break;
                    }
                    if diff == 1 {
                        count += 1;
                    }
                }
            }
        }

        count
    }
}