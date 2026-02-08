int mincostTickets(int* days, int daysSize, int* costs, int costsSize) {
    int lastDay = days[daysSize - 1];
    int* dp = (int*)malloc((lastDay + 1) * sizeof(int));
    for (int i = 0; i <= lastDay; i++) dp[i] = 0;

    int dayIndex = 0;
    for (int i = 1; i <= lastDay; i++) {
        if (i != days[dayIndex]) {
            dp[i] = dp[i - 1];
        } else {
            int cost1 = dp[i - 1] + costs[0];
            int cost7 = dp[(i - 7 > 0) ? i - 7 : 0] + costs[1];
            int cost30 = dp[(i - 30 > 0) ? i - 30 : 0] + costs[2];
            dp[i] = (cost1 < cost7) ? cost1 : cost7;
            dp[i] = (dp[i] < cost30) ? dp[i] : cost30;
            dayIndex++;
        }
    }
    int result = dp[lastDay];
    free(dp);
    return result;
}