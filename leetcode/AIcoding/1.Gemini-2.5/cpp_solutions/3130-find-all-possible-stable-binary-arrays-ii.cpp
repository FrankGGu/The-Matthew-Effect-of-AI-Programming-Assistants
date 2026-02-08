#include <vector>
#include <cmath> // For abs
#include <numeric> // Not strictly needed, but good practice for some problems

class Solution {
public:
    int numberOfStableArrays(int zeros, int ones, int limit) {
        long long MOD = 1e9 + 7;

        // dp[i][j][0] stores the number of stable arrays with 'i' zeros and 'j' ones, ending with a '0'.
        // dp[i][j][1] stores the number of stable arrays with 'i' zeros and 'j' ones, ending with a '1'.
        std::vector<std::vector<std::vector<long long>>> dp(zeros + 1, 
                                                             std::vector<std::vector<long long>>(ones + 1, 
                                                                                                  std::vector<long long>(2, 0)));

        // Base cases for arrays of length 1
        // An array "0" is stable if |1-0| <= limit
        if (zeros >= 1 && std::abs(1 - 0) <= limit) {
            dp[1][0][0] = 1;
        }
        // An array "1" is stable if |0-1| <= limit
        if (ones >= 1 && std::abs(0 - 1) <= limit) {
            dp[0][1][1] = 1;
        }

        // Fill the DP table for arrays of length 2 up to zeros + ones
        for (int i = 0; i <= zeros; ++i) {
            for (int j = 0; j <= ones; ++j) {
                // Skip empty array state (0 zeros, 0 ones)
                if (i == 0 && j == 0) continue;
                // Skip length 1 arrays which are handled by base cases
                if (i == 1 && j == 0) continue;
                if (i == 0 && j == 1) continue;

                // If the current prefix (i zeros, j ones) violates the limit,
                // then no stable array can be formed with this prefix.
                if (std::abs(i - j) > limit) {
                    continue;
                }

                // Calculate dp[i][j][0] (ending with '0')
                // To form an array ending with '0', we must have appended '0' to a
                // stable array with (i-1) zeros and j ones.
                if (i > 0) {
                    dp[i][j][0] = (dp[i-1][j][0] + dp[i-1][j][1]) % MOD;
                }

                // Calculate dp[i][j][1] (ending with '1')
                // To form an array ending with '1', we must have appended '1' to a
                // stable array with i zeros and (j-1) ones.
                if (j > 0) {
                    dp[i][j][1] = (dp[i][j-1][0] + dp[i][j-1][1]) % MOD;
                }
            }
        }

        // The total number of stable arrays with 'zeros' zeros and 'ones' ones
        // is the sum of those ending with '0' and those ending with '1'.
        long long total_stable_arrays = (dp[zeros][ones][0] + dp[zeros][ones][1]) % MOD;

        return static_cast<int>(total_stable_arrays);
    }
};