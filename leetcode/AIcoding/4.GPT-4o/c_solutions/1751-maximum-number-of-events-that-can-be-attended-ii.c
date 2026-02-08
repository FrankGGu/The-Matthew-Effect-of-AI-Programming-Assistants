int maxValue(int** events, int eventsSize, int* eventsColSize, int k) {
    int dp[k + 1][eventsSize + 1];
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j <= eventsSize; j++) {
            dp[i][j] = 0;
        }
    }

    qsort(events, eventsSize, sizeof(int*), [](const void* a, const void* b) {
        return (*(int**)a)[1] - (*(int**)b)[1];
    });

    for (int i = 1; i <= k; i++) {
        for (int j = 1; j <= eventsSize; j++) {
            dp[i][j] = dp[i][j - 1];
            int currentEnd = events[j - 1][1], currentValue = events[j - 1][2];
            for (int m = j - 1; m >= 1; m--) {
                if (events[m - 1][1] < events[j - 1][0]) {
                    dp[i][j] = fmax(dp[i][j], dp[i - 1][m] + currentValue);
                    break;
                }
            }
            dp[i][j] = fmax(dp[i][j], currentValue);
        }
    }

    return dp[k][eventsSize];
}