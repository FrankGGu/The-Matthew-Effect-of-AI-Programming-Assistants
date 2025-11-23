int minDistance(int* houses, int housesSize, int k) {
    if (k >= housesSize) return 0;

    qsort(houses, housesSize, sizeof(int), (int(*)(const void*, const void*))strcmp);

    int cost[housesSize][housesSize];
    for (int i = 0; i < housesSize; i++) {
        for (int j = i; j < housesSize; j++) {
            int median = houses[(i + j) / 2];
            cost[i][j] = 0;
            for (int m = i; m <= j; m++) {
                cost[i][j] += abs(houses[m] - median);
            }
        }
    }

    int dp[housesSize][k + 1];
    for (int i = 0; i < housesSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = INT_MAX / 2;
        }
    }

    for (int i = 0; i < housesSize; i++) {
        dp[i][1] = cost[0][i];
    }

    for (int mailboxes = 2; mailboxes <= k; mailboxes++) {
        for (int i = mailboxes - 1; i < housesSize; i++) {
            for (int j = mailboxes - 2; j < i; j++) {
                dp[i][mailboxes] = fmin(dp[i][mailboxes], dp[j][mailboxes - 1] + cost[j + 1][i]);
            }
        }
    }

    return dp[housesSize - 1][k];
}