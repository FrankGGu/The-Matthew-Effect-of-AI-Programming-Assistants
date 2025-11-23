impl Solution {
    pub fn num_decodings(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        dp[1] = if s[0] != '0' { 1 } else { 0 };

        for i in 2..=n {
            let one_digit = s[i - 1].to_digit(10).unwrap();
            let two_digits = (s[i - 2].to_digit(10).unwrap() * 10) + one_digit;

            if one_digit >= 1 && one_digit <= 9 {
                dp[i] += dp[i - 1];
            }

            if two_digits >= 10 && two_digits <= 26 {
                dp[i] += dp[i - 2];
            }
        }

        dp[n]
    }
}