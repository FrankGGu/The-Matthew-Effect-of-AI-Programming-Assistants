int minSkips(int* dist, int distSize, int speed, int hoursBefore) {
    int maxSkips = distSize;
    double dp[distSize + 1][maxSkips + 1];

    for (int i = 0; i <= distSize; i++) {
        for (int j = 0; j <= maxSkips; j++) {
            dp[i][j] = DBL_MAX;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= distSize; i++) {
        for (int j = 0; j <= i; j++) {
            for (int k = 1; k <= j + 1; k++) {
                if (i > 1 || j == 0) {
                    dp[i][j] = fmin(dp[i][j], ceil(dp[i - 1][j] + (double)dist[i - 1] / speed));
                }
                if (j > 0) {
                    dp[i][j] = fmin(dp[i][j], ceil(dp[i - 1][j - 1] + (double)dist[i - 1] / speed));
                }
            }
        }
    }

    for (int j = 0; j <= maxSkips; j++) {
        if (dp[distSize][j] <= hoursBefore) {
            return j;
        }
    }

    return -1;
}