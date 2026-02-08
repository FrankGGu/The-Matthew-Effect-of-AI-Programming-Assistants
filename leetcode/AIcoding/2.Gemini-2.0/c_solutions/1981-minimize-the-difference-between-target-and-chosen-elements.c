#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minAbsDifference(int** mat, int matSize, int* matColSize, int target) {
    int m = matSize;
    int n = matColSize[0];
    int max_sum = 0;
    for (int i = 0; i < m; i++) {
        int max_val = 0;
        for (int j = 0; j < n; j++) {
            if (mat[i][j] > max_val) {
                max_val = mat[i][j];
            }
        }
        max_sum += max_val;
    }

    int dp[max_sum + 1];
    for (int i = 0; i <= max_sum; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 0; i < m; i++) {
        int temp[max_sum + 1];
        for (int k = 0; k <= max_sum; k++) {
            temp[k] = 0;
        }
        for (int j = 0; j < n; j++) {
            for (int k = 0; k <= max_sum - mat[i][j]; k++) {
                if (dp[k]) {
                    temp[k + mat[i][j]] = 1;
                }
            }
        }
        for (int k = 0; k <= max_sum; k++) {
            dp[k] = dp[k] || temp[k];
        }
    }

    int min_diff = INT_MAX;
    for (int i = 0; i <= max_sum; i++) {
        if (dp[i]) {
            int diff = abs(i - target);
            if (diff < min_diff) {
                min_diff = diff;
            }
        }
    }

    return min_diff;
}