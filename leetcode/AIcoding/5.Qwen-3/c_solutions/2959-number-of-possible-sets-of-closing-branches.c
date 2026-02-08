#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int size;
} Set;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int dfs(int* nums, int n, int index, int target, int* dp) {
    if (target == 0) return 1;
    if (index >= n || target < 0) return 0;
    if (dp[target] != -1) return dp[target];

    int count = 0;
    for (int i = index; i < n; i++) {
        count += dfs(nums, n, i + 1, target - nums[i], dp);
    }
    dp[target] = count;
    return count;
}

int numberOfSets(int n, int k) {
    int* nums = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        nums[i] = i + 1;
    }

    qsort(nums, n, sizeof(int), compare);

    int maxSum = (n * (n + 1)) / 2;
    int* dp = (int*)malloc((k + 1) * sizeof(int));
    for (int i = 0; i <= k; i++) {
        dp[i] = -1;
    }

    int result = dfs(nums, n, 0, k, dp);

    free(nums);
    free(dp);
    return result;
}