int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int dfs(int* arr, int arrSize, int d, int* dp, int i) {
    if (dp[i] != -1) return dp[i];

    int res = 1;
    for (int j = i + 1; j <= min(i + d, arrSize - 1) && arr[j] < arr[i]; j++) {
        res = max(res, 1 + dfs(arr, arrSize, d, dp, j));
    }
    for (int j = i - 1; j >= max(i - d, 0) && arr[j] < arr[i]; j--) {
        res = max(res, 1 + dfs(arr, arrSize, d, dp, j));
    }

    dp[i] = res;
    return res;
}

int maxJumps(int* arr, int arrSize, int d) {
    int* dp = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        dp[i] = -1;
    }

    int res = 0;
    for (int i = 0; i < arrSize; i++) {
        res = max(res, dfs(arr, arrSize, d, dp, i));
    }

    free(dp);
    return res;
}