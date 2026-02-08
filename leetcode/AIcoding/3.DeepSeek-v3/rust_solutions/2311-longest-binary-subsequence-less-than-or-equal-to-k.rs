impl Solution {
    pub fn longest_subsequence(s: String, k: i32) -> i32 {
        let mut res = 0;
        let mut sum = 0;
        let mut base = 1;
        let s_bytes = s.as_bytes();

        for i in (0..s_bytes.len()).rev() {
            if s_bytes[i] == b'0' {
                res += 1;
            } else if res < 31 && sum + base <= k as i64 {
                sum += base;
                res += 1;
            }
            if base <= k as i64 {
                base *= 2;
            }
        }
        res as i32
    }
}