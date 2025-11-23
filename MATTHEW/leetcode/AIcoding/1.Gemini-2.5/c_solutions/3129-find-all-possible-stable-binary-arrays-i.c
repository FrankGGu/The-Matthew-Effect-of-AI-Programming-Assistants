#include <string.h> // Required for memset, though explicit loops are used here for clarity and safety in LeetCode environment

#define MOD 1000000007

long long dp[201][201][2];

int numberOfStableArrays(int zero, int one, int limit) {
    // Initialize dp table with zeros.
    // This is crucial for LeetCode as global/static arrays might retain values
    // from previous test cases.
    for (int i = 0; i <= zero; ++i) {
        for (int j = 0; j <= one; ++j) {
            dp[i][j][0] = 0;
            dp[i][j][1] = 0;
        }
    }

    // Iterate through all possible counts of zeros and ones
    for (int i = 0; i <= zero; ++i) {
        for (int j = 0; j <= one; ++j) {
            // An array with 0 zeros and 0 ones is an empty array, which doesn't
            // contribute to stable arrays of positive length.
            if (i == 0 && j == 0) {
                continue;
            }

            // Calculate dp[i][j][0]: number of stable arrays with 'i' zeros and 'j' ones, ending with '0'
            if (i > 0) { // Must have at least one '0' to end with '0'
                // Case 1: The array consists solely of '0's (no '1's yet)
                if (j == 0) {
                    // If the number of '0's does not exceed the limit, this sequence is valid.
                    // E.g., for limit=2, "0", "00" are valid. "000" is not.
                    if (i <= limit) {
                        dp[i][j][0] = 1;
                    }
                } else { // Case 2: The array ends with '0's, and previously ended with '1'
                    // We append 'k' zeros (where 1 <= k <= limit) to an array that ended with '1'.
                    // The previous state would have (i-k) zeros and 'j' ones, ending with '1'.
                    for (int k = 1; k <= limit; ++k) {
                        if (i - k >= 0) {
                            dp[i][j][0] = (dp[i][j][0] + dp[i - k][j][1]) % MOD;
                        }
                    }
                }
            }

            // Calculate dp[i][j][1]: number of stable arrays with 'i' zeros and 'j' ones, ending with '1'
            if (j > 0) { // Must have at least one '1' to end with '1'
                // Case 1: The array consists solely of '1's (no '0's yet)
                if (i == 0) {
                    // If the number of '1's does not exceed the limit, this sequence is valid.
                    if (j <= limit) {
                        dp[i][j][1] = 1;
                    }
                } else { // Case 2: The array ends with '1's, and previously ended with '0'
                    // We append 'k' ones (where 1 <= k <= limit) to an array that ended with '0'.
                    // The previous state would have 'i' zeros and (j-k) ones, ending with '0'.
                    for (int k = 1; k <= limit; ++k) {
                        if (j - k >= 0) {
                            dp[i][j][1] = (dp[i][j][1] + dp[i][j - k][0]) % MOD;
                        }
                    }
                }
            }
        }
    }

    // The total number of stable arrays is the sum of arrays ending with '0' and arrays ending with '1'
    // for the target counts of 'zero' and 'one'.
    return (int)((dp[zero][one][0] + dp[zero][one][1]) % MOD);
}