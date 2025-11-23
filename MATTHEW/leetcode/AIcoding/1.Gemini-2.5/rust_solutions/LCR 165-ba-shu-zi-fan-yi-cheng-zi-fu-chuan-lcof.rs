impl Solution {
    pub fn num_decodings(s: String) -> i32 {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();

        // dp_i_minus_2 corresponds to dp[i-2]
        // dp_i_minus_1 corresponds to dp[i-1]
        // current_dp corresponds to dp[i]

        // Initialize for dp[0] and dp[1]
        // dp[0] = 1 (represents one way to decode an empty string, for calculation purposes)
        let mut dp_i_minus_2 = 1; 

        // dp[1] calculation: based on s[0]
        // If s[0] is '0', it cannot be decoded, so dp[1] is 0.
        // Otherwise, it can be decoded as a single digit, so dp[1] is 1.
        let mut dp_i_minus_1 = if s_chars[0] == '0' { 0 } else { 1 };

        // Iterate from i = 2 up to n (to calculate dp[2] through dp[n])
        for i in 2..=n {
            let mut current_dp = 0;

            // Check single digit s[i-1]
            let single_digit = s_chars[i - 1].to_digit(10).unwrap();
            if single_digit >= 1 && single_digit <= 9 {
                // If the single digit is valid (1-9), add ways from dp[i-1]
                current_dp += dp_i_minus_1;
            }

            // Check two digits s[i-2]s[i-1]
            let two_digit_str = &s[i - 2..i];
            let two_digit_val = two_digit_str.parse::<i32>().unwrap();
            if two_digit_val >= 10 && two_digit_val <= 26 {
                // If the two-digit number is valid (10-26), add ways from dp[i-2]
                current_dp += dp_i_minus_2;
            }

            // Update for the next iteration:
            // dp[i-2] becomes dp[i-1]
            // dp[i-1] becomes dp[i]
            dp_i_minus_2 = dp_i_minus_1;
            dp_i_minus_1 = current_dp;
        }

        // After the loop, dp_i_minus_1 holds the result for dp[n]
        dp_i_minus_1
    }
}