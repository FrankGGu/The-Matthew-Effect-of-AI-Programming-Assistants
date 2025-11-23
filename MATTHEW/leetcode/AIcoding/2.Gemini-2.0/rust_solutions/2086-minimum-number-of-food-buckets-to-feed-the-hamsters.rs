impl Solution {
    pub fn buckets(hamsters: String) -> i32 {
        let s = hamsters.as_bytes();
        let n = s.len();
        let mut ans = 0;
        let mut i = 0;
        while i < n {
            if s[i] == b'H' {
                if i > 0 && s[i - 1] == b'B' {
                    i += 1;
                    continue;
                }
                if i < n - 1 && s[i + 1] == b'.' {
                    ans += 1;
                    i += 2;
                } else if i > 0 && s[i - 1] == b'.' {
                    ans += 1;
                    i += 1;
                } else {
                    return -1;
                }
            } else {
                i += 1;
            }
        }
        ans
    }
}