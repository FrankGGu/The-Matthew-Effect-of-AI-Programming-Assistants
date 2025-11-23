int mincostTickets(int* days, int daysSize, int* costs, int costsSize) {
    int maxDay = days[daysSize - 1];
    int* dp = (int*)calloc(maxDay + 1, sizeof(int));

    for (int i = 1; i <= maxDay; i++) {
        dp[i] = dp[i - 1];
        for (int j = 0; j < daysSize && days[j] == i; j++) {
            dp[i] = fmin(dp[i], dp[i - 1] + costs[0]);
            dp[i] = fmin(dp[i], dp[i - 7] + costs[1]);
            dp[i] = fmin(dp[i], dp[i - 30] + costs[2]);
        }
    }

    int result = dp[maxDay];
    free(dp);
    return result;
}