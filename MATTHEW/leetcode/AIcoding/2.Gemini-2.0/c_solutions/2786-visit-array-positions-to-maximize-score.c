#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long max(long long a, long long b) {
    return (a > b) ? a : b;
}

long long solve(int* nums, int numsSize, int x, int index, int parity, long long score, long long** dp) {
    if (index == numsSize) {
        return score;
    }

    if (dp[index][parity] != LLONG_MIN) {
        return dp[index][parity];
    }

    long long take = 0;
    if ((nums[index] % 2) == parity) {
        take = solve(nums, numsSize, x, index + 1, parity, score + nums[index], dp);
    } else {
        take = solve(nums, numsSize, x, index + 1, nums[index] % 2, score + nums[index] - x, dp);
    }

    long long skip = solve(nums, numsSize, x, index + 1, parity, score, dp);

    dp[index][parity] = max(take, skip);
    return dp[index][parity];
}

long long maxScore(int* nums, int numsSize, int x) {
    long long** dp = (long long**)malloc(numsSize * sizeof(long long*));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = (long long*)malloc(2 * sizeof(long long));
        dp[i][0] = dp[i][1] = LLONG_MIN;
    }

    long long ans = solve(nums, numsSize, x, 1, nums[0] % 2, nums[0], dp);

    for (int i = 0; i < numsSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return ans;
}