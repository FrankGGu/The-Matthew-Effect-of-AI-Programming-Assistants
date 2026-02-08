long long maxPoints(int** points, int pointsSize, int* pointsColSize) {
    int m = pointsSize;
    int n = pointsColSize[0];

    long long* dp = (long long*)malloc(n * sizeof(long long));
    for (int j = 0; j < n; j++) {
        dp[j] = points[0][j];
    }

    for (int i = 1; i < m; i++) {
        long long* left = (long long*)malloc(n * sizeof(long long));
        long long* right = (long long*)malloc(n * sizeof(long long));
        long long* new_dp = (long long*)malloc(n * sizeof(long long));

        left[0] = dp[0];
        for (int j = 1; j < n; j++) {
            left[j] = (dp[j] > left[j-1] - 1) ? dp[j] : left[j-1] - 1;
        }

        right[n-1] = dp[n-1];
        for (int j = n-2; j >= 0; j--) {
            right[j] = (dp[j] > right[j+1] - 1) ? dp[j] : right[j+1] - 1;
        }

        for (int j = 0; j < n; j++) {
            new_dp[j] = (left[j] > right[j] ? left[j] : right[j]) + points[i][j];
        }

        free(dp);
        free(left);
        free(right);
        dp = new_dp;
    }

    long long ans = 0;
    for (int j = 0; j < n; j++) {
        if (dp[j] > ans) ans = dp[j];
    }

    free(dp);
    return ans;
}