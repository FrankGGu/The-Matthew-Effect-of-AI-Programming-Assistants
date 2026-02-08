#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long combinations(int n, int k, long long** dp) {
    if (k < 0 || k > n) return 0;
    if (k == 0 || k == n) return 1;
    if (k > n / 2) k = n - k;
    if (dp[n][k] != -1) return dp[n][k];
    dp[n][k] = (combinations(n - 1, k - 1, dp) + combinations(n - 1, k, dp)) % 1000000007;
    return dp[n][k];
}

long long solve(int* nums, int numsSize, long long** dp) {
    if (numsSize <= 1) return 1;

    int root = nums[0];
    int left[numsSize];
    int right[numsSize];
    int leftSize = 0;
    int rightSize = 0;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < root) {
            left[leftSize++] = nums[i];
        } else {
            right[rightSize++] = nums[i];
        }
    }

    long long leftWays = solve(left, leftSize, dp) % 1000000007;
    long long rightWays = solve(right, rightSize, dp) % 1000000007;
    long long comb = combinations(numsSize - 1, leftSize, dp) % 1000000007;

    return (((leftWays * rightWays) % 1000000007) * comb) % 1000000007;
}

int numOfWays(int* nums, int numsSize) {
    long long** dp = (long long**)malloc((numsSize + 1) * sizeof(long long*));
    for (int i = 0; i <= numsSize; i++) {
        dp[i] = (long long*)malloc((numsSize + 1) * sizeof(long long));
        for (int j = 0; j <= numsSize; j++) {
            dp[i][j] = -1;
        }
    }

    long long result = solve(nums, numsSize, dp) % 1000000007;

    for (int i = 0; i <= numsSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return (result - 1 + 1000000007) % 1000000007;
}