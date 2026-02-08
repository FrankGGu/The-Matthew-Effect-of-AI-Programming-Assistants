class Solution {
    public int numberOfStableArrays(int zero, int one, int limit) {
        long MOD = 1_000_000_007;

        // dp[i][j][0] stores the number of stable binary arrays with i zeros and j ones, ending with a block of '0's.
        // dp[i][j][1] stores the number of stable binary arrays with i zeros and j ones, ending with a block of '1's.
        long[][][] dp = new long[zero + 1][one + 1][2];

        // Iterate through all possible counts of zeros (i) and ones (j)
        for (int i = 0; i <= zero; i++) {
            for (int j = 0; j <= one; j++) {
                // Skip the (0,0) state as an empty array is not a stable binary array
                if (i == 0 && j == 0) {
                    continue;
                }

                // Calculate dp[i][j][0] (arrays ending with '0')
                // This means we are appending a block of 'k' zeros (1 <= k <= limit)
                // to a previous stable array.
                for (int k = 1; k <= limit; k++) {
                    if (i - k >= 0) {
                        if (j == 0) { // If there are no ones, this array consists only of zeros.
                            // The only way to form 'i' zeros with 'j=0' is if 'i' is exactly 'k'
                            // (e.g., "0", "00", ..., "0...0" (k zeros)).
                            if (i == k) {
                                dp[i][j][0] = (dp[i][j][0] + 1) % MOD;
                            }
                        } else { // If there are ones, the previous part must have ended with a '1'.
                            // We append 'k' zeros to an array with (i-k) zeros and j ones, ending with '1'.
                            dp[i][j][0] = (dp[i][j][0] + dp[i - k][j][1]) % MOD;
                        }
                    }
                }

                // Calculate dp[i][j][1] (arrays ending with '1')
                // This means we are appending a block of 'k' ones (1 <= k <= limit)
                // to a previous stable array.
                for (int k = 1; k <= limit; k++) {
                    if (j - k >= 0) {
                        if (i == 0) { // If there are no zeros, this array consists only of ones.
                            // The only way to form 'j' ones with 'i=0' is if 'j' is exactly 'k'
                            // (e.g., "1", "11", ..., "1...1" (k ones)).
                            if (j == k) {
                                dp[i][j][1] = (dp[i][j][1] + 1) % MOD;
                            }
                        } else { // If there are zeros, the previous part must have ended with a '0'.
                            // We append 'k' ones to an array with i zeros and (j-k) ones, ending with '0'.
                            dp[i][j][1] = (dp[i][j][1] + dp[i][j - k][0]) % MOD;
                        }
                    }
                }
            }
        }

        // The total number of stable arrays is the sum of arrays ending with '0' and arrays ending with '1'.
        return (int) ((dp[zero][one][0] + dp[zero][one][1]) % MOD);
    }
}