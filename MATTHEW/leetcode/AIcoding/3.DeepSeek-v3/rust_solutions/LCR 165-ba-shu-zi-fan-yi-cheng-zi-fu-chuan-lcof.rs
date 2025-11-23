impl Solution {
    pub fn num_decodings(s: String) -> i32 {
        let bytes = s.as_bytes();
        let n = bytes.len();
        if n == 0 {
            return 0;
        }
        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        dp[1] = if bytes[0] == b'0' { 0 } else { 1 };
        for i in 2..=n {
            let one_digit = bytes[i - 1] - b'0';
            if one_digit != 0 {
                dp[i] += dp[i - 1];
            }
            let two_digits = (bytes[i - 2] - b'0') * 10 + (bytes[i - 1] - b'0');
            if two_digits >= 10 && two_digits <= 26 {
                dp[i] += dp[i - 2];
            }
        }
        dp[n]
    }
}