int sum, n;

int dfs(int* nums, int idx, int cnt, int cur, int** dp) {
    if (cnt == 0) return cur == 0;
    if (idx >= n) return 0;
    if (dp[idx][cur] != -1) return dp[idx][cur];
    int res = dfs(nums, idx + 1, cnt, cur, dp);
    if (cur >= nums[idx]) {
        res |= dfs(nums, idx + 1, cnt - 1, cur - nums[idx], dp);
    }
    dp[idx][cur] = res;
    return res;
}

int splitArraySameAverage(int* nums, int numsSize) {
    n = numsSize;
    sum = 0;
    for (int i = 0; i < n; i++) sum += nums[i];

    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc((sum + 1) * sizeof(int));
        for (int j = 0; j <= sum; j++) dp[i][j] = -1;
    }

    int possible = 0;
    for (int cnt = 1; cnt <= n / 2; cnt++) {
        if (sum * cnt % n != 0) continue;
        int target = sum * cnt / n;
        if (dfs(nums, 0, cnt, target, dp)) {
            possible = 1;
            break;
        }
    }

    for (int i = 0; i < n; i++) free(dp[i]);
    free(dp);

    return possible;
}