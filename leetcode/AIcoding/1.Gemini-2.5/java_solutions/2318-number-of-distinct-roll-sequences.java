class Solution {
    private static final int MOD = 1_000_000_007;
    private boolean[][] isCoprime;

    private void precomputeGCDs() {
        isCoprime = new boolean[7][7]; // 1-indexed for rolls 1-6
        for (int i = 1; i <= 6; i++) {
            for (int j = 1; j <= 6; j++) {
                if (gcd(i, j) == 1) {
                    isCoprime[i][j] = true;
                }
            }
        }
    }

    private int gcd(int a, int b) {
        if (b == 0) return a;
        return gcd(b, a % b);
    }

    public int distinctSequences(int n) {
        if (n == 1) {
            return 6;
        }

        precomputeGCDs();

        // dp[last_roll][prev_roll] stores the number of sequences of current length
        // ending with prev_roll then last_roll.
        long[][] dp = new long[7][7]; // 1-indexed for rolls 1-6

        // Initialize for length 2 sequences.
        // A sequence of length 2 is [prev_roll, last_roll].
        // Conditions: last_roll != prev_roll and gcd(last_roll, prev_roll) == 1.
        for (int last_roll = 1; last_roll <= 6; last_roll++) {
            for (int prev_roll = 1; prev_roll <= 6; prev_roll++) {
                if (last_roll != prev_roll && isCoprime[last_roll][prev_roll]) {
                    dp[last_roll][prev_roll] = 1;
                }
            }
        }

        // Iterate for sequence length k from 3 up to n.
        for (int k = 3; k <= n; k++) {
            long[][] new_dp = new long[7][7];
            for (int curr_roll = 1; curr_roll <= 6; curr_roll++) {
                for (int prev_roll = 1; prev_roll <= 6; prev_roll++) {
                    // Conditions for the current pair (prev_roll, curr_roll):
                    // 1. curr_roll must not be equal to prev_roll.
                    // 2. gcd(curr_roll, prev_roll) must be 1.
                    if (curr_roll == prev_roll || !isCoprime[curr_roll][prev_roll]) {
                        continue;
                    }

                    // Sum up valid sequences from the previous length (k-1).
                    // A sequence of length k-1 ends with (pprev_roll, prev_roll).
                    // We are extending it to (pprev_roll, prev_roll, curr_roll).
                    for (int pprev_roll = 1; pprev_roll <= 6; pprev_roll++) {
                        // Condition for the triplet (pprev_roll, prev_roll, curr_roll):
                        // 3. curr_roll must not be equal to pprev_roll.
                        if (curr_roll == pprev_roll) {
                            continue;
                        }

                        // Add the count of sequences of length k-1 ending with (pprev_roll, prev_roll).
                        // dp[prev_roll][pprev_roll] already satisfies conditions for (prev_roll, pprev_roll).
                        new_dp[curr_roll][prev_roll] = (new_dp[curr_roll][prev_roll] + dp[prev_roll][pprev_roll]) % MOD;
                    }
                }
            }
            dp = new_dp; // Update dp for the next iteration (next length)
        }

        // Sum up all valid sequences of length n.
        long total_sequences = 0;
        for (int last_roll = 1; last_roll <= 6; last_roll++) {
            for (int prev_roll = 1; prev_roll <= 6; prev_roll++) {
                total_sequences = (total_sequences + dp[last_roll][prev_roll]) % MOD;
            }
        }

        return (int) total_sequences;
    }
}