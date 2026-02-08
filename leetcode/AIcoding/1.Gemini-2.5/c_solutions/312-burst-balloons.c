#include <stdlib.h> // For malloc, calloc, free

int max(int a, int b) {
    return a > b ? a : b;
}

int maxCoins(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int n = numsSize;
    int* padded_nums = (int*)malloc(sizeof(int) * (n + 2));
    padded_nums[0] = 1;
    padded_nums[n + 1] = 1;
    for (int i = 0; i < n; i++) {
        padded_nums[i + 1] = nums[i];
    }

    int** dp = (int**)malloc(sizeof(int*) * (n + 2));
    for (int i = 0; i < n + 2; i++) {
        dp[i] = (int*)calloc(n + 2, sizeof(int));
    }

    for (int len = 1; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len + 1;
            for (int k = i + 1; k < j; k++) {
                int current_coins = padded_nums[i] * padded_nums[k] * padded_nums[j];
                int total_coins = dp[i][k] + dp[k][j] + current_coins;
                dp[i][j] = max(dp[i][j], total_coins);
            }
        }
    }

    int result = dp[0][n + 1];

    free(padded_nums);
    for (int i = 0; i < n + 2; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}