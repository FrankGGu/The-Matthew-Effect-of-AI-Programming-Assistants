impl Solution {
    pub fn knight_dialer(n: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;

        // Defines the possible knight moves from each digit.
        // Index represents the current digit, and the inner array contains digits it can move to.
        const NEXT_MOVES: &[&[usize]] = &[
            &[4, 6],    // 0
            &[6, 8],    // 1
            &[7, 9],    // 2
            &[4, 8],    // 3
            &[0, 3, 9], // 4
            &[],        // 5 (no moves from 5)
            &[0, 1, 7], // 6
            &[2, 6],    // 7
            &[1, 3],    // 8
            &[2, 4],    // 9
        ];

        // If n is 1, any of the 10 digits can be a phone number of length 1.
        if n == 1 {
            return 10;
        }

        // dp[digit] stores the number of distinct phone numbers of the current length
        // that end with 'digit'.
        // Initialize for n=1: each digit can start a number, so count is 1 for each.
        let mut dp: [i32; 10] = [1; 10];

        // Iterate from length 2 up to n
        for _k in 2..=n {
            // next_dp will store counts for the current length (k)
            let mut next_dp: [i32; 10] = [0; 10];

            // For each possible current digit (0-9)
            for digit in 0..10 {
                // If there are numbers of the previous length ending with 'digit'
                if dp[digit] > 0 {
                    // For each digit that 'digit' can move to
                    for &next_digit in NEXT_MOVES[digit] {
                        // Add the count of numbers ending with 'digit' to the count
                        // of numbers ending with 'next_digit' for the current length.
                        next_dp[next_digit] = (next_dp[next_digit] + dp[digit]) % MOD;
                    }
                }
            }
            // Update dp to be next_dp for the next iteration (next length)
            dp = next_dp;
        }

        // Sum all counts in the final dp array to get the total number of distinct phone numbers of length n.
        let mut total_count = 0;
        for count in dp.iter() {
            total_count = (total_count + count) % MOD;
        }

        total_count
    }
}