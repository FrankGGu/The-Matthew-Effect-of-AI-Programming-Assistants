#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int dfs(int* matchsticks, int n, int* used, int index, int target, int currentSum, int k) {
    if (k == 0) return 1;
    if (currentSum == target) return dfs(matchsticks, n, used, 0, target, 0, k - 1);
    for (int i = index; i < n; i++) {
        if (!used[i] && currentSum + matchsticks[i] <= target) {
            used[i] = 1;
            if (dfs(matchsticks, n, used, i + 1, target, currentSum + matchsticks[i], k)) return 1;
            used[i] = 0;
        }
    }
    return 0;
}

int canPartitionKSubsets(int* nums, int numsSize, int k) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) sum += nums[i];
    if (sum % k != 0) return 0;
    int target = sum / k;
    qsort(nums, numsSize, sizeof(int), compare);
    int* used = (int*)calloc(numsSize, sizeof(int));
    return dfs(nums, numsSize, used, 0, target, 0, k);
}

int* nums;
int numsSize;
int k;

int* matchsticksToSquare(int* nums, int numsSize, int* returnSize) {
    *returnSize = 1;
    int* result = (int*)malloc(sizeof(int));
    result[0] = canPartitionKSubsets(nums, numsSize, 4);
    return result;
}