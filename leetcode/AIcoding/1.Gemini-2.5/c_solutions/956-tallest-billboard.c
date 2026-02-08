#include <stdlib.h>
#include <string.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))

#define OFFSET 100000
#define MAX_DP_SIZE (2 * OFFSET + 1)

int dp[MAX_DP_SIZE];
int next_dp[MAX_DP_SIZE];

int tallestBillboard(int* rods, int rodsSize) {
    for (int i = 0; i < MAX_DP_SIZE; ++i) {
        dp[i] = -1;
    }

    dp[OFFSET] = 0;

    for (int r_idx = 0; r_idx < rodsSize; ++r_idx) {
        int rod = rods[r_idx];

        memcpy(next_dp, dp, sizeof(dp));

        for (int i = 0; i < MAX_DP_SIZE; ++i) {
            if (dp[i] == -1) {
                continue;
            }

            int current_shorter = dp[i];
            int current_diff = i - OFFSET;
            int current_taller = current_shorter + current_diff;

            // Option 1: Add rod to the taller billboard
            int new_taller_1 = current_taller + rod;
            int new_shorter_1 = current_shorter;
            int new_diff_1 = new_taller_1 - new_shorter_1;
            next_dp[new_diff_1 + OFFSET] = MAX(next_dp[new_diff_1 + OFFSET], new_shorter_1);

            // Option 2: Add rod to the shorter billboard
            int candidate_shorter_2 = current_shorter + rod;
            int candidate_taller_2 = current_taller;

            if (candidate_shorter_2 <= candidate_taller_2) {
                int new_shorter_2 = candidate_shorter_2;
                int new_taller_2 = candidate_taller_2;
                int new_diff_2 = new_taller_2 - new_shorter_2;
                next_dp[new_diff_2 + OFFSET] = MAX(next_dp[new_diff_2 + OFFSET], new_shorter_2);
            } else {
                int new_shorter_2 = candidate_taller_2;
                int new_taller_2 = candidate_shorter_2;
                int new_diff_2 = new_taller_2 - new_shorter_2;
                next_dp[new_diff_2 + OFFSET] = MAX(next_dp[new_diff_2 + OFFSET], new_shorter_2);
            }
        }
        memcpy(dp, next_dp, sizeof(dp));
    }

    return dp[OFFSET];
}