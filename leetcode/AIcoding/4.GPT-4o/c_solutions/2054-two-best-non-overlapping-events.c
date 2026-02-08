int maxTwoEvents(int** events, int eventsSize, int* eventsColSize) {
    int maxProfit = 0;
    int dp[eventsSize + 1][2]; // dp[i][0] = max profit using first i events, dp[i][1] = max profit including event i
    memset(dp, 0, sizeof(dp));

    qsort(events, eventsSize, sizeof(int*), cmp);

    for (int i = 0; i < eventsSize; i++) {
        dp[i + 1][0] = dp[i][0];
        dp[i + 1][1] = dp[i][1];

        for (int j = 0; j < i; j++) {
            if (events[j][1] < events[i][0]) {
                dp[i + 1][1] = fmax(dp[i + 1][1], dp[j + 1][0] + events[i][2]);
            }
        }

        dp[i + 1][0] = fmax(dp[i + 1][0], dp[i + 1][1]);
        maxProfit = fmax(maxProfit, dp[i + 1][0]);
    }

    return maxProfit;
}

int cmp(const void* a, const void* b) {
    return (*(int**)a)[0] - (*(int**)b)[0];
}