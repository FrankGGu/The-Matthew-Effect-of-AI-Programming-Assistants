#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int canSplit(int* nums, int numsSize, int target, int index, int count, int sum, int** dp, int* used) {
    if (count == 0) return sum == target;
    if (index >= numsSize) return 0;
    if (dp[index][count] != -1) return dp[index][count];

    int res = 0;
    for (int i = index; i < numsSize; i++) {
        if (!used[i]) {
            used[i] = 1;
            if (canSplit(nums, numsSize, target, i + 1, count - 1, sum + nums[i], dp, used)) {
                res = 1;
                break;
            }
            used[i] = 0;
        }
    }
    dp[index][count] = res;
    return res;
}

int splitArraySameAverage(int* nums, int numsSize) {
    if (numsSize == 1) return 0;

    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int** dp = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = (int*)malloc((numsSize + 1) * sizeof(int));
        for (int j = 0; j <= numsSize; j++) {
            dp[i][j] = -1;
        }
    }

    int* used = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        used[i] = 0;
    }

    for (int k = 1; k <= numsSize / 2; k++) {
        int target = (totalSum * k) / numsSize;
        if ((totalSum * k) % numsSize != 0) continue;
        if (canSplit(nums, numsSize, target, 0, k, 0, dp, used)) {
            free(used);
            for (int i = 0; i < numsSize; i++) {
                free(dp[i]);
            }
            free(dp);
            return 1;
        }
    }

    free(used);
    for (int i = 0; i < numsSize; i++) {
        free(dp[i]);
    }
    free(dp);
    return 0;
}