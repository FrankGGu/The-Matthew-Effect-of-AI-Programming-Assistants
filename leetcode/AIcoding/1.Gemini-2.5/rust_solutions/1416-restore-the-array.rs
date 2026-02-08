impl Solution {
    pub fn restore_the_array(s: String, k: i32) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let k_long = k as i64;
        let modulo = 1_000_000_007;

        let mut dp = vec![0; n + 1];
        dp[n] = 1; // Base case: an empty suffix has one way to be restored (as an empty array)

        // Iterate from the end of the string backwards
        for i in (0..n).rev() {
            // If the current digit is '0', it cannot start any valid number (1 to k)
            // So, no ways to form a number starting at this position. dp[i] remains 0.
            if s_bytes[i] == b'0' {
                continue;
            }

            let mut current_num: i64 = 0;
            // Iterate from the current position 'i' to form numbers s[i..j]
            for j in i..n {
                // Build the number digit by digit
                current_num = current_num * 10 + (s_bytes[j] - b'0') as i64;

                // If the current number exceeds k, then any further extension will also exceed k.
                // So, we can break the inner loop.
                if current_num > k_long {
                    break;
                }

                // If current_num is valid (1 <= current_num <= k_long),
                // add the number of ways from the remaining suffix s[j+1..n-1] to dp[i].
                // current_num is guaranteed to be >= 1 because s_bytes[i] is not '0'.
                dp[i] = (dp[i] + dp[j + 1]) % modulo;
            }
        }

        // The result is the number of ways to restore the array from the entire string s[0..n-1]
        dp[0]
    }
}