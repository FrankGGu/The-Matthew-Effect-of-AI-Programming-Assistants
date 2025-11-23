#include <stdlib.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxJumps(int* nums, int numsSize, int target) {
    if (numsSize == 0) {
        return -1;
    }

    int* dp = (int*)malloc(numsSize * sizeof(int));
    if (dp == NULL) {
        return -1;
    }

    for (int i = 0; i < numsSize; ++i) {
        dp[i] = INT_MIN;
    }

    dp[0] = 0;

    for (int i = 0; i < numsSize; ++i) {
        if (dp[i] == INT_MIN) {
            continue;
        }

        for (int j = i + 1; j < numsSize; ++j) {
            if (nums[i] + nums[j] == target) {
                dp[j] = max(dp[j], dp[i] + 1);
            }
        }
    }

    int result = dp[numsSize - 1];
    free(dp);

    if (result == INT_MIN) {
        return -1;
    } else {
        return result;
    }
}