impl Solution {
    pub fn num_decodings(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let s_chars: Vec<char> = s.chars().collect();
        let mut dp: Vec<i32> = vec![0; n + 1];

        // dp[0] represents the number of ways to decode an empty string, which is 1.
        // This is a base case for calculations.
        dp[0] = 1;

        for i in 1..=n {
            // Check one-digit decode
            // If the current digit is not '0', it can be decoded as a single digit.
            // The number of ways is then the number of ways to decode the prefix of length i-1.
            let c1 = s_chars[i - 1];
            if c1 != '0' {
                dp[i] += dp[i - 1];
            }

            // Check two-digit decode
            // If there are at least two digits (i >= 2), check if the last two digits form a valid number (10-26).
            // If they do, add the number of ways to decode the prefix of length i-2.
            if i >= 2 {
                let c2 = s_chars[i - 2];
                let num = (c2.to_digit(10).unwrap() * 10) + c1.to_digit(10).unwrap();

                if num >= 10 && num <= 26 {
                    dp[i] += dp[i - 2];
                }
            }
        }

        dp[n]
    }
}