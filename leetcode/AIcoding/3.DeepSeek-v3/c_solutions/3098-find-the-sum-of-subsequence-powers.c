#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int dp[51][51][101];

int dfs(int* nums, int numsSize, int k, int idx, int last, int last_idx, int* sorted, int sortedSize) {
    if (k == 0) return 1;
    if (idx == numsSize) return 0;

    if (last_idx != -1 && dp[idx][k][last_idx] != -1) {
        return dp[idx][k][last_idx];
    }

    int res = 0;
    int mod = 1000000007;

    res = (res + dfs(nums, numsSize, k, idx + 1, last, last_idx, sorted, sortedSize)) % mod;

    int current = nums[idx];
    int current_idx;
    for (current_idx = 0; current_idx < sortedSize; current_idx++) {
        if (sorted[current_idx] == current) break;
    }

    if (last_idx == -1) {
        res = (res + dfs(nums, numsSize, k - 1, idx + 1, current, current_idx, sorted, sortedSize)) % mod;
    } else {
        int diff = current - last;
        if (diff > 0) {
            long long power = 1;
            for (int i = 0; i < k - 1; i++) {
                power = (power * diff) % mod;
            }
            int add = (power * dfs(nums, numsSize, k - 1, idx + 1, current, current_idx, sorted, sortedSize)) % mod;
            res = (res + add) % mod;
        }
    }

    if (last_idx != -1) {
        dp[idx][k][last_idx] = res;
    }
    return res;
}

int sumOfPowers(int* nums, int numsSize, int k) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    memcpy(sorted, nums, numsSize * sizeof(int));
    qsort(sorted, numsSize, sizeof(int), cmp);

    memset(dp, -1, sizeof(dp));

    int result = dfs(nums, numsSize, k, 0, -1, -1, sorted, numsSize);
    free(sorted);
    return result;
}