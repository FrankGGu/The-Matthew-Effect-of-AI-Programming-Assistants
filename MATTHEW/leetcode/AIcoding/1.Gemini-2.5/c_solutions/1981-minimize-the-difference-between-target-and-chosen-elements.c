#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

#define MAX_POSSIBLE_SUM 4900

int minimizeTheDifference(int** mat, int matSize, int* matColSize, int target) {
    bool dp[MAX_POSSIBLE_SUM + 1];
    bool next_dp[MAX_POSSIBLE_SUM + 1];
    int n = matColSize[0];

    for (int i = 0; i <= MAX_POSSIBLE_SUM; ++i) {
        dp[i] = false;
    }

    for (int j = 0; j < n; ++j) {
        dp[mat[0][j]] = true;
    }

    for (int i = 1; i < matSize; ++i) {
        for (int k = 0; k <= MAX_POSSIBLE_SUM; ++k) {
            next_dp[k] = false;
        }

        for (int prev_sum = 0; prev_sum <= MAX_POSSIBLE_SUM; ++prev_sum) {
            if (dp[prev_sum]) {
                for (int j = 0; j < n; ++j) {
                    int current_num = mat[i][j];
                    if (prev_sum + current_num <= MAX_POSSIBLE_SUM) {
                        next_dp[prev_sum + current_num] = true;
                    }
                }
            }
        }
        for (int k = 0; k <= MAX_POSSIBLE_SUM; ++k) {
            dp[k] = next_dp[k];
        }
    }

    int min_diff = INT_MAX;
    for (int sum = 0; sum <= MAX_POSSIBLE_SUM; ++sum) {
        if (dp[sum]) {
            int diff = abs(sum - target);
            if (diff < min_diff) {
                min_diff = diff;
            }
        }
    }

    return min_diff;
}