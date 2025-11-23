#include <string.h> // For memset and memcpy

#define MAX_HATS 40
#define MAX_PEOPLE 10
#define MOD 1000000007

int dp[1 << MAX_PEOPLE];
int next_dp[1 << MAX_PEOPLE];

int hat_to_people[MAX_HATS + 1][MAX_PEOPLE];
int hat_to_people_counts[MAX_HATS + 1];

int numberWays(int** hats, int hatsSize, int* hatsColSize) {
    int n = hatsSize; // Number of people

    // Preprocessing: Build hat_to_people mapping
    memset(hat_to_people_counts, 0, sizeof(hat_to_people_counts));
    for (int p = 0; p < n; ++p) {
        for (int j = 0; j < hatsColSize[p]; ++j) {
            int hat_id = hats[p][j];
            hat_to_people[hat_id][hat_to_people_counts[hat_id]++] = p;
        }
    }

    // Initialize DP table
    memset(dp, 0, sizeof(dp));
    dp[0] = 1; // Base case: 1 way to assign no hats to no one (empty set of people)

    int all_people_mask = (1 << n) - 1;

    // Iterate through each hat ID from 1 to MAX_HATS
    for (int h = 1; h <= MAX_HATS; ++h) {
        // Initialize next_dp with current dp values.
        // This covers the case where hat 'h' is not used by anyone.
        memcpy(next_dp, dp, sizeof(int) * (1 << n));

        // Iterate through each person who likes the current hat 'h'
        for (int k = 0; k < hat_to_people_counts[h]; ++k) {
            int p = hat_to_people[h][k]; // Person 'p' likes hat 'h'

            // Iterate through all possible masks (representing people already assigned hats
            // using hats from 1 to h-1).
            for (int mask = 0; mask <= all_people_mask; ++mask) {
                // If person 'p' has NOT been assigned a hat in the current 'mask'
                if (!((mask >> p) & 1)) {
                    // Assign hat 'h' to person 'p'.
                    // The new mask will be 'mask | (1 << p)'.
                    // Add the ways from dp[mask] (ways to assign hats to 'mask' without 'p')
                    // to next_dp[mask | (1 << p)].
                    next_dp[mask | (1 << p)] = (next_dp[mask | (1 << p)] + dp[mask]) % MOD;
                }
            }
        }
        // Update dp for the next hat iteration
        memcpy(dp, next_dp, sizeof(int) * (1 << n));
    }

    // The final answer is dp[all_people_mask], which represents the number of ways
    // to assign hats to all 'n' people using distinct hats up to MAX_HATS.
    return dp[all_people_mask];
}