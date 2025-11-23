impl Solution {
    pub fn num_decodings(s: String) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();
        let modulo: i64 = 1_000_000_007;

        // dp[i] represents the number of ways to decode s[0...i-1]
        // We use space-optimized DP: prev2 for dp[i-2], prev1 for dp[i-1], curr for dp[i]

        // dp[0] = 1 (empty string has one way to decode)
        let mut prev2: i64 = 1; 

        // dp[1] calculation based on s[0]
        let mut prev1: i64 = 0;
        if chars[0] == '0' {
            prev1 = 0;
        } else if chars[0] == '*' {
            prev1 = 9;
        } else { // '1'-'9'
            prev1 = 1;
        }

        // If string length is 1, prev1 is the answer
        if n == 1 {
            return prev1 as i32;
        }

        // Iterate from i = 2 up to n (calculating dp[i])
        for i in 2..=n {
            let mut curr: i64 = 0;
            let c1 = chars[i - 1]; // current character (s[i-1])
            let c0 = chars[i - 2]; // previous character (s[i-2])

            // Case 1: Decode s[i-1] as a single digit
            if c1 == '*' {
                curr = (curr + prev1 * 9) % modulo;
            } else if c1 != '0' {
                curr = (curr + prev1) % modulo;
            }
            // If c1 == '0', it cannot be decoded as a single digit, so curr remains unchanged (0)

            // Case 2: Decode s[i-2]s[i-1] as a two-digit number
            if c0 == '1' {
                if c1 == '*' {
                    curr = (curr + prev2 * 10) % modulo; // '1*' can be 10-19 (10 ways)
                } else { // '10'-'19'
                    curr = (curr + prev2) % modulo; // '1' followed by '0'-'9' (1 way)
                }
            } else if c0 == '2' {
                if c1 == '*' {
                    curr = (curr + prev2 * 7) % modulo; // '2*' can be 20-26 (7 ways)
                } else if c1 >= '0' && c1 <= '6' { // '20'-'26'
                    curr = (curr + prev2) % modulo; // '2' followed by '0'-'6' (1 way)
                }
            } else if c0 == '*' {
                if c1 == '*' {
                    // '**' can be '1*' (10 ways) or '2*' (7 ways) = 17 ways
                    curr = (curr + prev2 * 17) % modulo;
                } else if c1 >= '0' && c1 <= '6' {
                    // '*0'-'*6': '*' can be '1' or '2' (e.g., *0 -> 10, 20) = 2 ways
                    curr = (curr + prev2 * 2) % modulo;
                } else if c1 >= '7' && c1 <= '9' {
                    // '*7'-'*9': '*' can only be '1' (e.g., *7 -> 17) = 1 way
                    curr = (curr + prev2 * 1) % modulo;
                }
            }
            // If c0 is '0' or '3'-'9', it cannot form a valid two-digit number with c1,
            // so curr remains unchanged for this case.

            // Update prev2 and prev1 for the next iteration
            prev2 = prev1;
            prev1 = curr;
        }

        prev1 as i32 // prev1 now holds dp[n]
    }
}