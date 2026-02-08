#include <stdlib.h>
#include <stdbool.h>

static int min(int a, int b) {
    return (a < b) ? a : b;
}

int minCostTickets(int* days, int daysSize, int* costs, int costsSize) {
    int max_day = 0;
    if (daysSize > 0) {
        max_day = days[daysSize - 1];
    }

    bool* isTravelDay = (bool*)calloc(max_day + 1, sizeof(bool));
    for (int i = 0; i < daysSize; i++) {
        isTravelDay[days[i]] = true;
    }

    int* dp = (int*)calloc(max_day + 1, sizeof(int));

    for (int i = 1; i <= max_day; i++) {
        if (!isTravelDay[i]) {
            dp[i] = dp[i-1];
        } else {
            int cost1 = dp[i-1] + costs[0];

            int cost7_prev_day = (i - 7 >= 0) ? dp[i-7] : 0;
            int cost7 = cost7_prev_day + costs[1];

            int cost30_prev_day = (i - 30 >= 0) ? dp[i-30] : 0;
            int cost30 = cost30_prev_day + costs[2];

            dp[i] = min(cost1, min(cost7, cost30));
        }
    }

    int result = dp[max_day];

    free(isTravelDay);
    free(dp);

    return result;
}