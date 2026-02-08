#include <limits.h>
#include <stdlib.h>

long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long mergeOperationsForMinimumTravelTime(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return 0;
    }

    long long** dp = (long long**)malloc(numsSize * sizeof(long long*));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = (long long*)malloc(numsSize * sizeof(long long));
    }

    long long* prefixSum = (long long*)malloc((numsSize + 1) * sizeof(long long));
    prefixSum[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixSum[i+1] = prefixSum[i] + nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        dp[i][i] = 0;
    }

    for (int len = 2; len <= numsSize; len++) {
        for (int i = 0; i <= numsSize - len; i++) {
            int j = i + len - 1;
            long long currentSubarraySum = prefixSum[j+1] - prefixSum[i];
            dp[i][j] = LLONG_MAX;

            for (int p = i; p < j; p++) {
                if (dp[i][p] != LLONG_MAX && dp[p+1][j] != LLONG_MAX) {
                    dp[i][j] = min(dp[i][j], dp[i][p] + dp[p+1][j] + currentSubarraySum);
                }
            }
        }
    }

    long long result = dp[0][numsSize-1];

    for (int i = 0; i < numsSize; i++) {
        free(dp[i]);
    }
    free(dp);
    free(prefixSum);

    return result;
}