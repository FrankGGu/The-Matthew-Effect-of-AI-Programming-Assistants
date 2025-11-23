#include <stdio.h>

#define MOD 1000000007

int checkRecord(int n) {
    // dp_curr[j][k] represents the number of valid records of current length
    // j: number of 'A's (0 for no 'A', 1 for one 'A')
    // k: consecutive 'L's at the end (0, 1, or 2)
    // dp_next[j][k] will store counts for the next length

    long long dp_curr[2][3] = {0};
    long long dp_next[2][3] = {0};

    // Base case: For a record of length 0 (empty string)
    // There is 1 way: 0 'A's, 0 consecutive 'L's
    dp_curr[0][0] = 1;

    // Iterate for each length from 0 up to n-1
    for (int i = 0; i < n; i++) {
        // Clear dp_next for the current iteration (to calculate for length i+1)
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 3; k++) {
                dp_next[j][k] = 0;
            }
        }

        // Iterate through all possible states for the current length i
        for (int j = 0; j < 2; j++) { // 'A' count
            for (int k = 0; k < 3; k++) { // 'L' count
                if (dp_curr[j][k] == 0) {
                    continue; // Skip if no ways lead to this state
                }

                long long current_ways = dp_curr[j][k];

                // Option 1: Add 'P' (Present)
                // 'A' count remains j, 'L' count resets to 0
                dp_next[j][0] = (dp_next[j][0] + current_ways) % MOD;

                // Option 2: Add 'A' (Absent)
                // Can only add 'A' if j is 0 (no 'A's used yet)
                // 'A' count becomes 1, 'L' count resets to 0
                if (j == 0) {
                    dp_next[1][0] = (dp_next[1][0] + current_ways) % MOD;
                }

                // Option 3: Add 'L' (Late)
                // 'A' count remains j, 'L' count increases by 1 (if less than 2)
                if (k < 2) {
                    dp_next[j][k + 1] = (dp_next[j][k + 1] + current_ways) % MOD;
                }
            }
        }

        // Move dp_next values to dp_curr for the next iteration
        // (dp_curr now holds counts for length i+1)
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 3; k++) {
                dp_curr[j][k] = dp_next[j][k];
            }
        }
    }

    // Sum all valid states for length n (which are now in dp_curr)
    long long total_ways = 0;
    for (int j = 0; j < 2; j++) {
        for (int k = 0; k < 3; k++) {
            total_ways = (total_ways + dp_curr[j][k]) % MOD;
        }
    }

    return (int)total_ways;
}