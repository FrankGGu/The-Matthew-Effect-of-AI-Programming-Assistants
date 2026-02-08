#include <stdbool.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

bool canWin(int* nums, int numsSize) {
    if (numsSize == 0) {
        return true;
    }
    if (numsSize == 1) {
        return true;
    }

    int** dp = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; ++i) {
        dp[i] = (int*)malloc(numsSize * sizeof(int));
    }

    for (int i = 0; i < numsSize; ++i) {
        dp[i][i] = nums[i];
    }

    for (int len = 2; len <= numsSize; ++len) {
        for (int i = 0; i <= numsSize - len; ++i) {
            int j = i + len - 1;
            int choice1 = nums[i] - dp[i+1][j];
            int choice2 = nums[j] - dp[i][j-1];
            dp[i][j] = max(choice1, choice2);
        }
    }

    bool result = dp[0][numsSize - 1] >= 0;

    for (int i = 0; i < numsSize; ++i) {
        free(dp[i]);
    }
    free(dp);

    return result;
}