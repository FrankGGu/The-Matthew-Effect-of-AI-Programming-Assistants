int minCost(int* cut, int cutSize, int total) {
    int dp[cutSize + 2][cutSize + 2];
    for (int i = 0; i <= cutSize + 1; i++) {
        for (int j = 0; j <= cutSize + 1; j++) {
            dp[i][j] = 0;
        }
    }
    cut[cutSize] = 0;
    cut[cutSize + 1] = total;
    qsort(cut, cutSize + 2, sizeof(int), cmp);

    for (int len = 2; len <= cutSize + 1; len++) {
        for (int i = 0; i + len <= cutSize + 1; i++) {
            dp[i][i + len] = INT_MAX;
            for (int j = i + 1; j < i + len; j++) {
                dp[i][i + len] = fmin(dp[i][i + len], dp[i][j] + dp[j][i + len] + cut[i + len] - cut[i]);
            }
        }
    }
    return dp[0][cutSize + 1];
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}