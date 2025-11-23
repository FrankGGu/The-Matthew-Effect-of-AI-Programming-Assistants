impl Solution {
    pub fn number_of_arrays(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let k = k as i64;
        let n = s.len();
        let mut dp = vec![0; n + 1];
        dp[n] = 1;
        let modulo = 1_000_000_007;

        for i in (0..n).rev() {
            if s[i] == b'0' {
                dp[i] = 0;
                continue;
            }
            let mut num = 0i64;
            let mut j = i;
            while j < n {
                num = num * 10 + (s[j] - b'0') as i64;
                if num > k {
                    break;
                }
                dp[i] = (dp[i] + dp[j + 1]) % modulo;
                j += 1;
            }
        }

        dp[0] as i32
    }
}