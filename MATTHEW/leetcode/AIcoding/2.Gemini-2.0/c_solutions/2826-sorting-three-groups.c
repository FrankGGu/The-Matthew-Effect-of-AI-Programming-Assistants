#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(int* nums, int numsSize) {
    int count1 = 0, count2 = 0, count3 = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) count1++;
        else if (nums[i] == 2) count2++;
        else count3++;
    }

    int dp[numsSize + 1][4];
    for (int i = 0; i <= numsSize; i++) {
        for (int j = 0; j < 4; j++) {
            dp[i][j] = INT_MAX;
        }
    }
    dp[0][0] = 0;

    for (int i = 1; i <= numsSize; i++) {
        for (int j = 0; j < 4; j++) {
            if (dp[i - 1][j] == INT_MAX) continue;

            for (int k = 1; k <= 3; k++) {
                if (k >= j) {
                    int cost = dp[i - 1][j] + (nums[i - 1] != k);
                    if (cost < dp[i][k]) {
                        dp[i][k] = cost;
                    }
                }
            }
        }
    }

    int min_ops = INT_MAX;
    for (int i = 1; i <= 3; i++) {
        if (dp[numsSize][i] < min_ops) {
            min_ops = dp[numsSize][i];
        }
    }

    return min_ops;
}