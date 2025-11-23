class Solution {
    public int numberOfStableArrays(int zeros, int ones, int limit) {
        final int MOD = 1_000_000_007;

        // dp[i][j][0] stores the number of stable binary arrays with i zeros and j ones, ending with a 0.
        // dp[i][j][1] stores the number of stable binary arrays with i zeros and j ones, ending with a 1.
        long[][][] dp = new long[zeros + 1][ones + 1][2];

        // Iterate through all possible counts of zeros
        for (int i = 0; i <= zeros; i++) {
            // Iterate through all possible counts of ones
            for (int j = 0; j <= ones; j++) {
                // Base case: no zeros and no ones
                if (i == 0 && j == 0) {
                    continue;
                }

                // Calculate dp[i][j][0] (ending with 0)
                if (i > 0) {
                    if (j == 0) {
                        // If there are only zeros, an array like "00...0" is stable
                        // only if its length does not exceed 'limit'.
                        if (i <= limit) {
                            dp[i][j][0] = 1;
                        }
                    } else {
                        // General case: i zeros and j ones, ending with 0.
                        // This can be formed by:
                        // 1. Appending a '0' to an array with (i-1) zeros and j ones, ending with '0'.
                        //    (Extending a block of zeros)
                        // 2. Appending a '0' to an array with (i-1) zeros and j ones, ending with '1'.
                        //    (Starting a new block of zeros)
                        dp[i][j][0] = (dp[i - 1][j][0] + dp[i - 1][j][1]) % MOD;

                        // Subtract invalid cases: if the block of zeros exceeds 'limit'.
                        // An invalid block of (limit + 1) zeros is formed by appending a '0'
                        // to an array that already had 'limit' trailing zeros.
                        // Such an array (with 'limit' trailing zeros) would have been formed by
                        // appending 'limit' zeros to an array ending with '1'.
                        // This corresponds to dp[i - limit - 1][j][1].
                        if (i - limit - 1 >= 0) {
                            dp[i][j][0] = (dp[i][j][0] - dp[i - limit - 1][j][1] + MOD) % MOD;
                        }
                    }
                }

                // Calculate dp[i][j][1] (ending with 1)
                if (j > 0) {
                    if (i == 0) {
                        // If there are only ones, an array like "11...1" is stable
                        // only if its length does not exceed 'limit'.
                        if (j <= limit) {
                            dp[i][j][1] = 1;
                        }
                    } else {
                        // General case: i zeros and j ones, ending with 1.
                        // This can be formed by:
                        // 1. Appending a '1' to an array with i zeros and (j-1) ones, ending with '1'.
                        //    (Extending a block of ones)
                        // 2. Appending a '1' to an array with i zeros and (j-1) ones, ending with '0'.
                        //    (Starting a new block of ones)
                        dp[i][j][1] = (dp[i][j - 1][1] + dp[i][j - 1][0]) % MOD;

                        // Subtract invalid cases: if the block of ones exceeds 'limit'.
                        // Similar to the zeros case, subtract dp[i][j - limit - 1][0].
                        if (j - limit - 1 >= 0) {
                            dp[i][j][1] = (dp[i][j][1] - dp[i][j - limit - 1][0] + MOD) % MOD;
                        }
                    }
                }
            }
        }

        // The total number of stable arrays is the sum of arrays ending with 0 and arrays ending with 1.
        return (int) ((dp[zeros][ones][0] + dp[zeros][ones][1]) % MOD);
    }
}