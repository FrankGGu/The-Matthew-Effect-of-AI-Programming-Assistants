#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minChanges(int* nums, int numsSize, int k) {
    int max_num = 1024;
    int* freq[k];
    for (int i = 0; i < k; i++) {
        freq[i] = (int*)calloc(max_num, sizeof(int));
    }
    int* counts = (int*)calloc(k, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[i % k][nums[i]]++;
        counts[i % k]++;
    }

    int dp[k + 1][max_num];
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j < max_num; j++) {
            dp[i][j] = 1e9;
        }
    }
    dp[0][0] = 0;

    for (int i = 0; i < k; i++) {
        int min_cost = 1e9;
        for (int j = 0; j < max_num; j++) {
            min_cost = fmin(min_cost, dp[i][j]);
        }
        for (int j = 0; j < max_num; j++) {
            dp[i + 1][j] = fmin(dp[i + 1][j], dp[i][j] + counts[i] - freq[i][j]);
            dp[i + 1][j] = fmin(dp[i + 1][j], min_cost + counts[i]);
        }
    }

    for (int i = 0; i < k; i++) {
        free(freq[i]);
    }
    free(counts);

    return dp[k][0];
}