#include <vector>

class Solution {
public:
    int checkRecord(int n) {
        long long MOD = 1e9 + 7;

        // dp[j][k] stores the number of valid attendance records of length 'i'
        // j: number of 'A's (0 or 1)
        // k: number of consecutive 'L's at the end (0, 1, or 2)
        //
        // dp[0][0]: records with 0 'A's, ending with 'P' (or empty record)
        // dp[0][1]: records with 0 'A's, ending with 'L'
        // dp[0][2]: records with 0 'A's, ending with 'LL'
        // dp[1][0]: records with 1 'A', ending with 'P' or 'A'
        // dp[1][1]: records with 1 'A', ending with 'L'
        // dp[1][2]: records with 1 'A', ending with 'LL'

        std::vector<std::vector<long long>> dp(2, std::vector<long long>(3, 0));

        // Base case: For length 0, there is one empty record, with 0 'A's and 0 'L's.
        // This represents the starting point for building records.
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            std::vector<std::vector<long long>> next_dp(2, std::vector<long long>(3, 0));

            // Calculate states for 0 'A's
            // next_dp[0][0]: records with 0 'A's, ending with 'P'
            // Can come from any state with 0 'A's by appending 'P'
            next_dp[0][0] = (dp[0][0] + dp[0][1] + dp[0][2]) % MOD;

            // next_dp[0][1]: records with 0 'A's, ending with 'L'
            // Can come from state dp[0][0] (ending with P or empty) by appending 'L'
            next_dp[0][1] = dp[0][0];

            // next_dp[0][2]: records with 0 'A's, ending with 'LL'
            // Can come from state dp[0][1] (ending with L) by appending 'L'
            next_dp[0][2] = dp[0][1];

            // Calculate states for 1 'A'
            // next_dp[1][0]: records with 1 'A', ending with 'P' or 'A'
            // Option 1: Append 'P' to any state with 1 'A'
            next_dp[1][0] = (dp[1][0] + dp[1][1] + dp[1][2]) % MOD;
            // Option 2: Append 'A' to any state with 0 'A's
            next_dp[1][0] = (next_dp[1][0] + dp[0][0] + dp[0][1] + dp[0][2]) % MOD;

            // next_dp[1][1]: records with 1 'A', ending with 'L'
            // Can come from state dp[1][0] (ending with P or A) by appending 'L'
            next_dp[1][1] = dp[1][0];

            // next_dp[1][2]: records with 1 'A', ending with 'LL'
            // Can come from state dp[1][1] (ending with L) by appending 'L'
            next_dp[1][2] = dp[1][1];

            // Update dp for the next iteration
            dp = next_dp;
        }

        long long total_records = 0;
        // Sum up all possible valid states for length 'n'
        for (int j = 0; j < 2; ++j) {
            for (int k = 0; k < 3; ++k) {
                total_records = (total_records + dp[j][k]) % MOD;
            }
        }

        return static_cast<int>(total_records);
    }
};