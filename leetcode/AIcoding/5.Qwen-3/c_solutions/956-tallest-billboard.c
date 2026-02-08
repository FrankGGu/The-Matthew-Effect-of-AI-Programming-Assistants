#include <stdio.h>
#include <stdlib.h>

int* dp;
int maxDiff;

int dfs(int* nums, int n, int index, int diff) {
    if (diff < 0) return 0;
    if (index == n) return diff == 0 ? 0 : -1;
    if (dp[diff] != -1) return dp[diff];

    int add = dfs(nums, n, index + 1, diff + nums[index]);
    int subtract = dfs(nums, n, index + 1, diff - nums[index]);
    int neither = dfs(nums, n, index + 1, diff);

    int result = -1;
    if (add != -1) result = add + nums[index];
    if (subtract != -1) result = (result == -1) ? subtract : (result > subtract ? result : subtract);
    if (neither != -1) result = (result == -1) ? neither : (result > neither ? result : neither);

    dp[diff] = result;
    return dp[diff];
}

int tallestBillboard(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) sum += nums[i];
    maxDiff = sum;
    dp = (int*)malloc((sum + 1) * sizeof(int));
    for (int i = 0; i <= sum; i++) dp[i] = -1;
    int result = dfs(nums, numsSize, 0, 0);
    free(dp);
    return result;
}