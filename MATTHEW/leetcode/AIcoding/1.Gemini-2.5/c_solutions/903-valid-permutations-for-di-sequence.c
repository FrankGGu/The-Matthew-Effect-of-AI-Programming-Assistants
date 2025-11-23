#include <string.h>
#include <stdlib.h>

int numPermsDISequence(char * s) {
    int n = strlen(s);
    long long MOD = 1000000007;

    // dp[j] stores the number of permutations of (0, ..., current_len-1)
    // such that the last element P[current_len-1] is j.
    // The 'current_len' implicitly increases from 1 to n+1.
    // The size of dp needs to be n+1, as j can go up to n.
    long long* dp = (long long*)calloc(n + 1, sizeof(long long));
    long long* new_dp = (long long*)calloc(n + 1, sizeof(long long));

    // Base case: current_len = 1. Permutation (0). P[0] = 0.
    // dp[0] represents the count for a permutation of length 1 ending with 0.
    dp[0] = 1;

    // Iterate for current_len from 1 to n.
    // In each iteration, we are building permutations of (0, ..., current_len)
    // from permutations of (0, ..., current_len-1).
    // The character s[current_len-1] dictates the relation between P[current_len-1] and P[current_len].
    for (int current_len = 1; current_len <= n; ++current_len) {
        // Reset new_dp for the current length calculation
        for (int j = 0; j <= current_len; ++j) {
            new_dp[j] = 0;
        }

        char op = s[current_len - 1];

        if (op == 'I') { // s[current_len-1] == 'I' means P[current_len-1] < P[current_len]
            // If P[current_len] is j, then P[current_len-1] must be some k < j.
            // new_dp[j] = sum(dp[k]) for k from 0 to j-1.
            // This can be computed efficiently as:
            // new_dp[j] = (new_dp[j-1] + dp[j-1]) % MOD for j > 0.
            // new_dp[0] must be 0 (cannot have P[current_len]=0 if P[current_len-1] < P[current_len]).
            // new_dp[0] is already 0 from the reset loop.
            for (int j = 1; j <= current_len; ++j) {
                new_dp[j] = (new_dp[j - 1] + dp[j - 1]) % MOD;
            }
        } else { // op == 'D', s[current_len-1] == 'D' means P[current_len-1] > P[current_len]
            // If P[current_len] is j, then P[current_len-1] must be some k > j.
            // new_dp[j] = sum(dp[k]) for k from j to current_len-1.
            // This can be computed efficiently as:
            // new_dp[j] = (new_dp[j+1] + dp[j]) % MOD for j < current_len.
            // new_dp[current_len] must be 0 (cannot have P[current_len]=current_len if P[current_len-1] > P[current_len]).
            // new_dp[current_len] is already 0 from the reset loop.
            for (int j = current_len - 1; j >= 0; --j) {
                new_dp[j] = (new_dp[j + 1] + dp[j]) % MOD;
            }
        }

        // Copy new_dp to dp for the next iteration.
        // dp now holds counts for permutations of (0, ..., current_len).
        for (int j = 0; j <= current_len; ++j) {
            dp[j] = new_dp[j];
        }
    }

    long long total_perms = 0;
    // After the loop, dp contains the counts for permutations of (0, ..., n)
    // where dp[j] is the count of permutations ending with j.
    // Sum all possibilities for the last element P[n].
    for (int j = 0; j <= n; ++j) {
        total_perms = (total_perms + dp[j]) % MOD;
    }

    free(dp);
    free(new_dp);

    return (int)total_perms;
}