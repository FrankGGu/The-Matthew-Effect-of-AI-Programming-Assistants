int minDistance(int* houses, int housesSize, int k) {
    int max = houses[housesSize - 1] - houses[0];
    int dp[101][101] = {0};
    for (int i = 0; i < housesSize; i++) {
        for (int j = i; j < housesSize; j++) {
            dp[i][j] = 0;
            for (int m = i; m <= j; m++) {
                dp[i][j] += abs(houses[m] - houses[(i + j) / 2]);
            }
        }
    }

    int f[101][101] = {0};
    for (int i = 0; i <= housesSize; i++) {
        for (int j = 1; j <= k; j++) {
            f[i][j] = max;
        }
    }
    f[0][0] = 0;

    for (int i = 1; i <= housesSize; i++) {
        for (int j = 1; j <= k; j++) {
            for (int m = 0; m < i; m++) {
                f[i][j] = fmin(f[i][j], f[m][j - 1] + dp[m][i - 1]);
            }
        }
    }
    return f[housesSize][k];
}