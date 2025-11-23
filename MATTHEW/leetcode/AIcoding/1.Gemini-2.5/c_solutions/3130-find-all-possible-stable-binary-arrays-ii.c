#include <stdio.h>

long long dp[1001][1001][2];
long long sum_dp0_col[1001]; // sum_dp0_col[j] stores sum(dp[x][j][1]) for x in window [i-limit0, i-1]
long long sum_dp1_row[1001]; // sum_dp1_row[i] stores sum(dp[i][x][0]) for x in window [j-limit1, j-1]

int numberOfStableArrays(int zero, int one, int limit0, int limit1) {
    long long MOD = 1e9 + 7;

    // Initialize dp table and sum arrays to 0
    // For global/static arrays in C, this is implicitly done.
    // If this function were called multiple times, explicit clearing would be needed.
    // For typical LeetCode execution, global arrays are reset for each test case.
    for (int i = 0; i <= zero; ++i) {
        for (int j = 0; j <= one; ++j) {
            dp[i][j][0] = 0;
            dp[i][j][1] = 0;
        }
    }
    for (int j = 0; j <= one; ++j) sum_dp0_col[j] = 0;
    for (int i = 0; i <= zero; ++i) sum_dp1_row[i] = 0;

    // Loop through all possible counts of zeros (i) and ones (j)
    for (int i = 0; i <= zero; ++i) {
        for (int j = 0; j <= one; ++j) {
            if (i == 0 && j == 0) {
                continue;
            }

            // Calculate dp[i][j][0] (number of stable arrays with i zeros, j ones, ending with 0)
            if (j == 0) { // Array only has zeros (e.g., "000")
                if (i > 0 && i <= limit0) { // If it's a valid length for a block of zeros
                    dp[i][j][0] = 1;
                }
            } else { // Array has both zeros and ones (e.g., "...111000")
                // dp[i][j][0] is the sum of dp[i-k][j][1] for k from 1 to min(i, limit0)
                // This sum is efficiently maintained in sum_dp0_col[j]
                dp[i][j][0] = sum_dp0_col[j];
            }

            // Calculate dp[i][j][1] (number of stable arrays with i zeros, j ones, ending with 1)
            if (i == 0) { // Array only has ones (e.g., "111")
                if (j > 0 && j <= limit1) { // If it's a valid length for a block of ones
                    dp[i][j][1] = 1;
                }
            } else { // Array has both zeros and ones (e.g., "...000111")
                // dp[i][j][1] is the sum of dp[i][j-k][0] for k from 1 to min(j, limit1)
                // This sum is efficiently maintained in sum_dp1_row[i]
                dp[i][j][1] = sum_dp1_row[i];
            }

            // Update sliding window sums for the next iterations

            // Update sum_dp0_col[j] for (i+1, j) to calculate dp[i+1][j][0]
            // sum_dp0_col[j] should represent sum(dp[x][j][1]) for x in [i+1-limit0, i]
            // Add dp[i][j][1]
            sum_dp0_col[j] = (sum_dp0_col[j] + dp[i][j][1]) % MOD;
            // Remove dp[i-limit0][j][1] if it falls out of the window
            if (i - limit0 >= 0) {
                sum_dp0_col[j] = (sum_dp0_col[j] - dp[i - limit0][j][1] + MOD) % MOD;
            }

            // Update sum_dp1_row[i] for (i, j+1) to calculate dp[i][j+1][1]
            // sum_dp1_row[i] should represent sum(dp[i][x][0]) for x in [j+1-limit1, j]
            // Add dp[i][j][0]
            sum_dp1_row[i] = (sum_dp1_row[i] + dp[i][j][0]) % MOD;
            // Remove dp[i][j-limit1][0] if it falls out of the window
            if (j - limit1 >= 0) {
                sum_dp1_row[i] = (sum_dp1_row[i] - dp[i][j - limit1][0] + MOD) % MOD;
            }
        }
    }

    // The total number of stable arrays is the sum of arrays ending with 0 and arrays ending with 1
    // for the target counts (zero, one).
    long long ans = (dp[zero][one][0] + dp[zero][one][1]) % MOD;

    return (int)ans;
}