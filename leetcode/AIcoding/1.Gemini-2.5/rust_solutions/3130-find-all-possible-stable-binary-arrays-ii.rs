impl Solution {
    pub fn number_of_stable_arrays(zero: i32, one: i32, limit: i32) -> i32 {
        let zero_count = zero as usize;
        let one_count = one as usize;
        let limit = limit as usize;
        let modulo = 1_000_000_007;

        // dp[i][j][0] = number of stable arrays with i zeros and j ones, ending with 0
        // dp[i][j][1] = number of stable arrays with i zeros and j ones, ending with 1
        let mut dp = vec![vec![vec![0; 2]; one_count + 1]; zero_count + 1];

        // Base cases: Arrays consisting of only one type of character are always stable.
        // An array of 'i' zeros: "00...0"
        for i in 1..=zero_count {
            dp[i][0][0] = 1;
        }
        // An array of 'j' ones: "11...1"
        for j in 1..=one_count {
            dp[0][j][1] = 1;
        }

        // Fill the DP table for arrays containing both zeros and ones
        // i represents the count of zeros, j represents the count of ones
        for i in 1..=zero_count {
            for j in 1..=one_count {
                // Calculate dp[i][j][0] (ending with 0)
                // This array ends with '0'. It must be formed by appending '0' to a previous stable array.
                // The previous array has (i-1) zeros and j ones.

                // Sum of ways to form stable arrays with (i-1) zeros and j ones, ending with '0' or '1'.
                // This sum represents all ways to append a '0' to a stable array of length (i-1)+j.
                let mut val_0 = (dp[i-1][j][0] + dp[i-1][j][1]) % modulo;

                // Subtract invalid sequences: ...0 (limit+1 '1's) 0
                // An invalid sequence is formed if the current '0' is preceded by 'limit+1' '1's,
                // which in turn were preceded by a '0'.
                // The count of such arrays (ending with 'limit+1' ones, preceded by '0')
                // is dp[i-1][j - (limit+1)][0].
                if j >= limit + 1 {
                    val_0 = (val_0 - dp[i-1][j - (limit+1)][0] + modulo) % modulo;
                }
                dp[i][j][0] = val_0;

                // Calculate dp[i][j][1] (ending with 1)
                // This array ends with '1'. It must be formed by appending '1' to a previous stable array.
                // The previous array has i zeros and (j-1) ones.

                // Sum of ways to form stable arrays with i zeros and (j-1) ones, ending with '0' or '1'.
                // This sum represents all ways to append a '1' to a stable array of length i+(j-1).
                let mut val_1 = (dp[i][j-1][0] + dp[i][j-1][1]) % modulo;

                // Subtract invalid sequences: ...1 (limit+1 '0's) 1
                // Similar logic as for '0', but for '1's and '0's swapped.
                // The count of such arrays (ending with 'limit+1' zeros, preceded by '1')
                // is dp[i - (limit+1)][j-1][1].
                if i >= limit + 1 {
                    val_1 = (val_1 - dp[i - (limit+1)][j-1][1] + modulo) % modulo;
                }
                dp[i][j][1] = val_1;
            }
        }

        // The final answer is the sum of stable arrays ending with '0' or '1'
        // using all 'zero_count' zeros and 'one_count' ones.
        ((dp[zero_count][one_count][0] + dp[zero_count][one_count][1]) % modulo) as i32
    }
}