impl Solution {
    pub fn num_decodings(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut dp = vec![0; n + 1];
        dp[0] = 1;

        for i in 1..=n {
            let one_digit = s_bytes[i - 1] as char;
            if one_digit != '0' {
                if one_digit == '*' {
                    dp[i] = (dp[i] + 9 * dp[i - 1]) % 1000000007;
                } else {
                    dp[i] = (dp[i] + dp[i - 1]) % 1000000007;
                }
            }

            if i > 1 {
                let two_digits = String::from_utf8(vec![s_bytes[i - 2], s_bytes[i - 1]]).unwrap();
                if two_digits == "**" {
                    dp[i] = (dp[i] + 15 * dp[i - 2]) % 1000000007;
                } else if two_digits.starts_with('*') {
                    let second_digit = s_bytes[i - 1] as char;
                    if second_digit >= '0' && second_digit <= '6' {
                        dp[i] = (dp[i] + 2 * dp[i - 2]) % 1000000007;
                    } else {
                        dp[i] = (dp[i] + dp[i - 2]) % 1000000007;
                    }
                } else if two_digits.ends_with('*') {
                    let first_digit = s_bytes[i - 2] as char;
                    if first_digit == '1' {
                        dp[i] = (dp[i] + 9 * dp[i - 2]) % 1000000007;
                    } else if first_digit == '2' {
                        dp[i] = (dp[i] + 6 * dp[i - 2]) % 1000000007;
                    }
                } else {
                    let num = two_digits.parse::<i32>().unwrap();
                    if num >= 10 && num <= 26 {
                        dp[i] = (dp[i] + dp[i - 2]) % 1000000007;
                    }
                }
            }
        }

        dp[n] as i32
    }
}