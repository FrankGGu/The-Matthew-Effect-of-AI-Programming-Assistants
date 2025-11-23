#include <string.h> // For strlen
#include <stdlib.h> // For MAX, though a macro is used

#define MAX(a, b) ((a) > (b) ? (a) : (b))

int dp[2][501][501]; 

int findTheMaximumLength(char* s1, char* s2, int k) {
    int N = strlen(s1);
    int M = strlen(s2);

    // Initialize dp array with -1 (indicating not reachable)
    // This initializes both the 'prev' (dp[0]) and 'curr' (dp[1]) rows.
    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j <= M; ++j) {
            for (int l = 0; l <= k; ++l) {
                dp[i][j][l] = -1;
            }
        }
    }

    // Base case: empty prefixes of both strings with 0 mismatches has length 0.
    dp[0][0][0] = 0;

    for (int i = 1; i <= N; ++i) {
        int curr = i % 2;
        int prev = (i - 1) % 2;

        // Reset current row for new calculations
        // This ensures that states not reachable from previous row are -1.
        for (int j = 0; j <= M; ++j) {
            for (int l = 0; l <= k; ++l) {
                dp[curr][j][l] = -1;
            }
        }

        // Handle the case for an empty prefix of s2 (j=0).
        // If dp[prev][0][0] (representing s1[0...i-2] and empty s2 prefix with 0 mismatches)
        // was reachable, then dp[curr][0][0] (representing s1[0...i-1] and empty s2 prefix with 0 mismatches)
        // is also reachable with length 0.
        if (dp[prev][0][0] != -1) {
             dp[curr][0][0] = MAX(dp[curr][0][0], dp[prev][0][0]);
        }

        for (int j = 1; j <= M; ++j) {
            for (int l = 0; l <= k; ++l) {
                // Option 1: Skip s1[i-1]
                // The length comes from the state considering s1[0...i-2] and s2[0...j-1]
                if (dp[prev][j][l] != -1) {
                    dp[curr][j][l] = MAX(dp[curr][j][l], dp[prev][j][l]);
                }

                // Option 2: Skip s2[j-1]
                // The length comes from the state considering s1[0...i-1] and s2[0...j-2]
                if (dp[curr][j-1][l] != -1) {
                    dp[curr][j][l] = MAX(dp[curr][j][l], dp[curr][j-1][l]);
                }

                // Option 3: Consider s1[i-1] and s2[j-1]
                if (s1[i-1] == s2[j-1]) {
                    // Match: no mismatch cost, length increases by 1
                    if (dp[prev][j-1][l] != -1) {
                        dp[curr][j][l] = MAX(dp[curr][j][l], dp[prev][j-1][l] + 1);
                    }
                } else {
                    // Mismatch: consume one mismatch budget, length increases by 1
                    if (l > 0 && dp[prev][j-1][l-1] != -1) {
                        dp[curr][j][l] = MAX(dp[curr][j][l], dp[prev][j-1][l-1] + 1);
                    }
                }
            }
        }
    }

    int maxLength = 0;
    int final_curr_row = N % 2; // The row corresponding to the full s1 string
    for (int l = 0; l <= k; ++l) {
        maxLength = MAX(maxLength, dp[final_curr_row][M][l]);
    }

    return maxLength;
}