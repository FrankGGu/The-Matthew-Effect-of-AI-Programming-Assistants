int minSkips(int* dist, int distSize, int speed, int hoursBefore) {
    int n = distSize;
    double eps = 1e-9;
    double** dp = (double**)malloc((n + 1) * sizeof(double*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (double*)malloc((n + 1) * sizeof(double));
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 1e20;
        }
    }

    dp[0][0] = 0;
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= i; j++) {
            if (j <= i - 1) {
                dp[i][j] = fmin(dp[i][j], ceil(dp[i-1][j] + (double)dist[i-1] / speed - eps));
            }
            if (j > 0) {
                dp[i][j] = fmin(dp[i][j], dp[i-1][j-1] + (double)dist[i-1] / speed);
            }
        }
    }

    for (int j = 0; j <= n; j++) {
        if (dp[n][j] <= hoursBefore + eps) {
            for (int i = 0; i <= n; i++) free(dp[i]);
            free(dp);
            return j;
        }
    }

    for (int i = 0; i <= n; i++) free(dp[i]);
    free(dp);
    return -1;
}