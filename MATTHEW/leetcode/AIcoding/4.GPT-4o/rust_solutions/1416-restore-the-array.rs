impl Solution {
    pub fn number_of_arrays(s: String, k: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let n = s.len();
        let k = k as i64;
        let mut dp = vec![0; n + 1];
        dp[0] = 1;

        for i in 1..=n {
            let mut num = 0;
            for j in (1..=10).rev() {
                if i >= j {
                    num = num * 10 + (s.as_bytes()[i - j] - b'0') as i64;
                    if num > k {
                        break;
                    }
                    dp[i] = (dp[i] + dp[i - j]) % mod_val;
                }
            }
        }

        dp[n]
    }
}