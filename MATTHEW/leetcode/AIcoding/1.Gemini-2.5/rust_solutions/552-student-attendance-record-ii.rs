impl Solution {
    pub fn check_record(n: i32) -> i32 {
        let n = n as usize;
        let modulo: i32 = 1_000_000_007;

        // dp[num_A][consec_L] stores the number of valid attendance records
        // num_A: 0 (no 'A's), 1 (one 'A')
        // consec_L: 0 (ends with 'P' or 'A', or is an empty string),
        //           1 (ends with 'L'),
        //           2 (ends with 'LL')
        let mut dp: Vec<Vec<i32>> = vec![vec![0; 3]; 2];

        // Base case: For length 0, there's one way (empty string) with 0 'A's and 0 consecutive 'L's.
        dp[0][0] = 1;

        // Iterate for each length from 1 to n
        for _i in 0..n {
            let mut next_dp: Vec<Vec<i32>> = vec![vec![0; 3]; 2];

            for num_a in 0..2 {
                for consec_l in 0..3 {
                    if dp[num_a][consec_l] == 0 {
                        continue; // No records for this state, skip
                    }

                    // Case 1: Append 'P' (Present)
                    // Number of 'A's remains the same. Consecutive 'L's reset to 0.
                    next_dp[num_a][0] = (next_dp[num_a][0] + dp[num_a][consec_l]) % modulo;

                    // Case 2: Append 'L' (Late)
                    // Number of 'A's remains the same. Consecutive 'L's increase by 1.
                    // Can only append 'L' if current consecutive 'L's are less than 2 (to avoid 'LLL').
                    if consec_l < 2 {
                        next_dp[num_a][consec_l + 1] = (next_dp[num_a][consec_l + 1] + dp[num_a][consec_l]) % modulo;
                    }

                    // Case 3: Append 'A' (Absent)
                    // Number of 'A's becomes 1. Consecutive 'L's reset to 0.
                    // Can only append 'A' if there are currently 0 'A's (to avoid more than one 'A').
                    if num_a == 0 {
                        next_dp[1][0] = (next_dp[1][0] + dp[num_a][consec_l]) % modulo;
                    }
                }
            }
            // Update dp for the next iteration
            dp = next_dp;
        }

        // Sum up all valid records of length n
        let mut total_records = 0;
        for num_a in 0..2 {
            for consec_l in 0..3 {
                total_records = (total_records + dp[num_a][consec_l]) % modulo;
            }
        }

        total_records
    }
}