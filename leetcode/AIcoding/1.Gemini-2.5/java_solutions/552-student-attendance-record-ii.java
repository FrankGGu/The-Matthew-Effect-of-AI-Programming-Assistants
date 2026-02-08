class Solution {
    public int checkRecord(int n) {
        final int MOD = 1_000_000_007;

        // dp[j][k] represents the number of valid attendance records of length i
        // j: number of 'A's (0 or 1)
        // k: number of consecutive 'L's at the end (0, 1, or 2)
        // We use two layers for DP: prev_dp for length i-1 and curr_dp for length i
        long[][] prev_dp = new long[2][3]; // [numA][consecutiveL]
        long[][] curr_dp = new long[2][3];

        // Base case: For length 0, there is one empty record, with 0 'A's and 0 'L's.
        prev_dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            // Initialize curr_dp for current length i
            for (int j = 0; j < 2; j++) {
                for (int k = 0; k < 3; k++) {
                    curr_dp[j][k] = 0;
                }
            }

            // Calculate states for current length i

            // Case 1: Append 'P'
            // If we append 'P', consecutive 'L's reset to 0. Number of 'A's remains the same.
            // Records with 0 'A's ending with 'P':
            curr_dp[0][0] = (prev_dp[0][0] + prev_dp[0][1] + prev_dp[0][2]) % MOD;
            // Records with 1 'A' ending with 'P':
            curr_dp[1][0] = (prev_dp[1][0] + prev_dp[1][1] + prev_dp[1][2]) % MOD;

            // Case 2: Append 'L'
            // If we append 'L', consecutive 'L's count increases by 1. Number of 'A's remains the same.
            // This is only allowed if previous consecutive 'L's was < 2.
            // Records with 0 'A's ending with 'L':
            curr_dp[0][1] = (curr_dp[0][1] + prev_dp[0][0]) % MOD; // previous was 0 L's, now 1 L
            curr_dp[0][2] = (curr_dp[0][2] + prev_dp[0][1]) % MOD; // previous was 1 L, now 2 L's
            // Records with 1 'A' ending with 'L':
            curr_dp[1][1] = (curr_dp[1][1] + prev_dp[1][0]) % MOD; // previous was 0 L's, now 1 L
            curr_dp[1][2] = (curr_dp[1][2] + prev_dp[1][1]) % MOD; // previous was 1 L, now 2 L's

            // Case 3: Append 'A'
            // If we append 'A', consecutive 'L's reset to 0. Number of 'A's increases by 1.
            // This is only allowed if the previous record had 0 'A's.
            // So, it contributes to curr_dp[1][0].
            curr_dp[1][0] = (curr_dp[1][0] + prev_dp[0][0] + prev_dp[0][1] + prev_dp[0][2]) % MOD;

            // Update prev_dp for the next iteration
            for (int j = 0; j < 2; j++) {
                for (int k = 0; k < 3; k++) {
                    prev_dp[j][k] = curr_dp[j][k];
                }
            }
        }

        // Sum up all valid records for length n
        long totalRecords = 0;
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 3; k++) {
                totalRecords = (totalRecords + prev_dp[j][k]) % MOD;
            }
        }

        return (int) totalRecords;
    }
}