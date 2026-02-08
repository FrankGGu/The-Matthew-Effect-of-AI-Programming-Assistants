impl Solution {
    pub fn integer_break(n: i32) -> i32 {
        if n == 2 {
            return 1;
        }
        if n == 3 {
            return 2;
        }

        let n_usize = n as usize;
        let mut dp = vec![0; n_usize + 1];

        // dp[i] stores the maximum product when breaking integer i.
        // These are the base cases for the DP table itself.
        dp[2] = 1; // 2 = 1 + 1, product = 1
        dp[3] = 2; // 3 = 1 + 2, product = 2

        // Fill the dp table for numbers from 4 up to n
        for i in 4..=n_usize {
            let mut max_prod_for_i = 0;
            // Iterate through possible first parts 'j'
            // The other part will be 'i - j'
            for j in 1..i {
                let j_i32 = j as i32;
                let i_minus_j_i32 = (i - j) as i32;

                // Option 1: Treat both 'j' and 'i - j' as direct factors (not breaking them further)
                let prod_direct = j_i32 * i_minus_j_i32;

                // Option 2: Treat 'j' as a direct factor, and break 'i - j' further
                // (using the pre-calculated maximum product for 'i - j' from dp table)
                let prod_broken_right = j_i32 * dp[i - j];

                // Update the maximum product for 'i'
                max_prod_for_i = max_prod_for_i.max(prod_direct).max(prod_broken_right);
            }
            dp[i] = max_prod_for_i;
        }

        dp[n_usize]
    }
}