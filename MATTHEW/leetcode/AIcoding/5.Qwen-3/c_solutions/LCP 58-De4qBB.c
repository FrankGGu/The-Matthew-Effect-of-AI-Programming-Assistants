#include <stdio.h>
#include <stdlib.h>

int* nums;
int numsSize;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int dfs(int index, int target, int* dp) {
    if (target == 0) return 0;
    if (index >= numsSize) return -1;
    if (dp[index] != -1) return dp[index];

    int min = -1;
    for (int i = index; i < numsSize; i++) {
        if (nums[i] <= target) {
            int res = dfs(i + 1, target - nums[i], dp);
            if (res != -1) {
                if (min == -1 || res + 1 < min) {
                    min = res + 1;
                }
            }
        }
    }
    dp[index] = min;
    return min;
}

int findMinimumMoves(int* cubes, int cubesSize) {
    nums = cubes;
    numsSize = cubesSize;
    qsort(nums, numsSize, sizeof(int), compare);

    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    int* dp = (int*)malloc((numsSize + 1) * sizeof(int));
    for (int i = 0; i <= numsSize; i++) {
        dp[i] = -1;
    }

    int result = dfs(0, total, dp);
    free(dp);
    return result;
}