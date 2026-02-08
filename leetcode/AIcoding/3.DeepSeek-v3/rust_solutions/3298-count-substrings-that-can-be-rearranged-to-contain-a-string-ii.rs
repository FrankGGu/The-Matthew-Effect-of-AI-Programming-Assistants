impl Solution {
    pub fn count_substrings(s: String, t: String) -> i64 {
        let s = s.as_bytes();
        let t = t.as_bytes();
        let m = s.len();
        let n = t.len();
        let mut res = 0;

        for i in 0..m {
            for j in 0..n {
                let mut diff = 0;
                let mut k = 0;
                while i + k < m && j + k < n {
                    if s[i + k] != t[j + k] {
                        diff += 1;
                        if diff > 1 {
                            break;
                        }
                    }
                    if diff == 1 {
                        res += 1;
                    }
                    k += 1;
                }
            }
        }
        res
    }
}