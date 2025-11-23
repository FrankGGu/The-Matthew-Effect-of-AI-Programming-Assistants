int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int minCost(int n, int* cuts, int cutsSize) {
    int m = cutsSize;
    int* arr = (int*)malloc(sizeof(int) * (m + 2));
    for (int i = 0; i < m; i++) {
        arr[i + 1] = cuts[i];
    }
    arr[0] = 0;
    arr[m + 1] = n;
    qsort(arr, m + 2, sizeof(int), cmp);

    int** dp = (int**)malloc(sizeof(int*) * (m + 2));
    for (int i = 0; i < m + 2; i++) {
        dp[i] = (int*)malloc(sizeof(int) * (m + 2));
        for (int j = 0; j < m + 2; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = 2; len <= m + 1; len++) {
        for (int i = 0; i + len <= m + 1; i++) {
            int j = i + len;
            dp[i][j] = INT_MAX;
            for (int k = i + 1; k < j; k++) {
                int cost = dp[i][k] + dp[k][j] + arr[j] - arr[i];
                if (cost < dp[i][j]) {
                    dp[i][j] = cost;
                }
            }
        }
    }

    int result = dp[0][m + 1];

    for (int i = 0; i < m + 2; i++) {
        free(dp[i]);
    }
    free(dp);
    free(arr);

    return result;
}