#include <string.h> // For memset

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int dp[7][7];
int new_dp[7][7];
int is_valid_pair[7][7]; // is_valid_pair[prev][curr] means prev, curr is a valid adjacent pair

const int MOD = 1000000007;

int distinctSequences(int n) {
    if (n == 1) {
        return 6;
    }

    // Precompute GCD and valid adjacent pairs
    for (int i = 1; i <= 6; ++i) {
        for (int j = 1; j <= 6; ++j) {
            is_valid_pair[i][j] = (i != j && gcd(i, j) == 1);
        }
    }

    // Base case for n = 2
    // dp[curr_roll][prev_roll] stores count of sequences of length 2 ending with (prev_roll, curr_roll)
    for (int i = 1; i <= 6; ++i) { // prev_roll
        for (int j = 1; j <= 6; ++j) { // curr_roll
            if (is_valid_pair[i][j]) {
                dp[j][i] = 1; // Sequence (i, j)
            } else {
                dp[j][i] = 0;
            }
        }
    }

    // DP for length k from 3 to n
    for (int k = 3; k <= n; ++k) {
        // Clear new_dp for current iteration
        memset(new_dp, 0, sizeof(new_dp));

        // Iterate through all possible (prev_roll, curr_roll) pairs for the new sequence
        for (int curr_roll = 1; curr_roll <= 6; ++curr_roll) {
            for (int prev_roll = 1; prev_roll <= 6; ++prev_roll) {
                // If (prev_roll, curr_roll) is a valid adjacent pair
                if (is_valid_pair[prev_roll][curr_roll]) {
                    // Find second_prev_roll such that (second_prev_roll, prev_roll, curr_roll) is valid
                    for (int second_prev_roll = 1; second_prev_roll <= 6; ++second_prev_roll) {
                        // Check (second_prev_roll, prev_roll) validity
                        if (is_valid_pair[second_prev_roll][prev_roll]) {
                            // Check the third constraint: second_prev_roll != curr_roll (a != c for a, b, c)
                            if (second_prev_roll != curr_roll) {
                                new_dp[curr_roll][prev_roll] = (new_dp[curr_roll][prev_roll] + dp[prev_roll][second_prev_roll]) % MOD;
                            }
                        }
                    }
                }
            }
        }

        // Copy new_dp to dp for the next iteration
        memcpy(dp, new_dp, sizeof(dp));
    }

    // Sum all counts for sequences of length n
    long long total_sequences = 0;
    for (int i = 1; i <= 6; ++i) {
        for (int j = 1; j <= 6; ++j) {
            total_sequences = (total_sequences + dp[i][j]) % MOD;
        }
    }

    return (int)total_sequences;
}