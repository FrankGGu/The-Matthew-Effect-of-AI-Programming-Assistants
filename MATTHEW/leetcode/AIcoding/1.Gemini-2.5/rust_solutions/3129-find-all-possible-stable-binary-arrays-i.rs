impl Solution {
    pub fn number_of_stable_binary_arrays(zeros: i32, ones: i32, limit: i32) -> i32 {
        let zeros = zeros as usize;
        let ones = ones as usize;
        let limit = limit as usize;
        let modulo = 1_000_000_007;

        // dp[i][j][last_char][consecutive_count]
        // i: number of zeros used
        // j: number of ones used
        // last_char: 0 for '0', 1 for '1'
        // consecutive_count: number of consecutive last_char at the end
        let mut dp = vec![vec![vec![vec![0; limit + 1]; 2]; ones + 1]; zeros + 1];

        // total_ways_ending_0[i][j]: total ways to form an array with i zeros and j ones, ending with '0'
        let mut total_ways_ending_0 = vec![vec![0; ones + 1]; zeros + 1];
        // total_ways_ending_1[i][j]: total ways to form an array with i zeros and j ones, ending with '1'
        let mut total_ways_ending_1 = vec![vec![0; ones + 1]; zeros + 1];

        // Base cases for arrays of length 1
        // A single character '0' or '1' forms a sequence of 1 consecutive character.
        // This is only valid if limit >= 1.
        if limit >= 1 {
            if zeros >= 1 {
                dp[1][0][0][1] = 1;
                total_ways_ending_0[1][0] = 1;
            }
            if ones >= 1 {
                dp[0][1][1][1] = 1;
                total_ways_ending_1[0][1] = 1;
            }
        }

        for i in 0..=zeros {
            for j in 0..=ones {
                // Skip empty array (0,0) and base cases (1,0), (0,1) as they are already initialized
                if (i == 0 && j == 0) || (i == 1 && j == 0) || (i == 0 && j == 1) {
                    continue;
                }

                // Calculate ways ending with '0'
                if i > 0 { // If we have zeros to place
                    // Case 1: Append '0' after an array ending with '1'
                    // This creates a sequence of one '0'.
                    dp[i][j][0][1] = (dp[i][j][0][1] + total_ways_ending_1[i - 1][j]) % modulo;

                    // Case 2: Append '0' after an array ending with '0'
                    // This extends an existing '0' sequence.
                    for l_consecutive in 2..=limit {
                        dp[i][j][0][l_consecutive] = (dp[i][j][0][l_consecutive] + dp[i - 1][j][0][l_consecutive - 1]) % modulo;
                    }
                }

                // Calculate ways ending with '1'
                if j > 0 { // If we have ones to place
                    // Case 1: Append '1' after an array ending with '0'
                    // This creates a sequence of one '1'.
                    dp[i][j][1][1] = (dp[i][j][1][1] + total_ways_ending_0[i][j - 1]) % modulo;

                    // Case 2: Append '1' after an array ending with '1'
                    // This extends an existing '1' sequence.
                    for l_consecutive in 2..=limit {
                        dp[i][j][1][l_consecutive] = (dp[i][j][1][l_consecutive] + dp[i][j - 1][1][l_consecutive - 1]) % modulo;
                    }
                }

                // Update total_ways_ending_0 and total_ways_ending_1 for current (i, j)
                for l_consecutive in 1..=limit {
                    total_ways_ending_0[i][j] = (total_ways_ending_0[i][j] + dp[i][j][0][l_consecutive]) % modulo;
                    total_ways_ending_1[i][j] = (total_ways_ending_1[i][j] + dp[i][j][1][l_consecutive]) % modulo;
                }
            }
        }

        let mut final_ans = 0;
        final_ans = (final_ans + total_ways_ending_0[zeros][ones]) % modulo;
        final_ans = (final_ans + total_ways_ending_1[zeros][ones]) % modulo;

        final_ans as i32
    }
}