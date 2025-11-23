#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxGoodSubsequenceLength(char *s, int* nums, int numsSize) {
    int n = strlen(s);
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        memset(dp[i], 0, n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i == j) {
                dp[i][j] = (nums[i] == s[i] - '0') ? 1 : 0;
            } else {
                dp[i][j] = 0;
                if (nums[i] == s[j] - '0') {
                    dp[i][j] = 1;
                    if (i > 0 && j > 0) {
                        dp[i][j] += dp[i-1][j-1];
                    }
                } else {
                    if (i > 0) dp[i][j] = max(dp[i][j], dp[i-1][j]);
                    if (j > 0) dp[i][j] = max(dp[i][j], dp[i][j-1]);
                }
            }
        }
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            result = max(result, dp[i][j]);
        }
    }

    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}