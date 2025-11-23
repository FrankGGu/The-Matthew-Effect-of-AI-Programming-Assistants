#include <stdio.h>
#include <stdlib.h>

int minCostForTickets(int* tickets, int ticketsSize, int* costs, int costsSize) {
    int maxDay = 0;
    for (int i = 0; i < ticketsSize; i++) {
        if (tickets[i] > maxDay) {
            maxDay = tickets[i];
        }
    }

    int* dp = (int*)malloc((maxDay + 1) * sizeof(int));
    for (int i = 0; i <= maxDay; i++) {
        dp[i] = 0;
    }

    int day = 0;
    for (int i = 1; i <= maxDay; i++) {
        if (day < ticketsSize && i == tickets[day]) {
            int cost1 = dp[i - 1] + costs[0];
            int cost2 = (i >= 7) ? dp[i - 7] + costs[1] : costs[1];
            int cost3 = (i >= 30) ? dp[i - 30] + costs[2] : costs[2];
            dp[i] = fmin(fmin(cost1, cost2), cost3);
            day++;
        } else {
            dp[i] = dp[i - 1];
        }
    }

    int result = dp[maxDay];
    free(dp);
    return result;
}