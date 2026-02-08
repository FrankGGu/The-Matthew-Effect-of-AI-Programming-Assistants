#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCostTickets(int* days, int daysSize, int* costs, int costsSize) {
    int dp[366] = {0};
    int maxDay = days[daysSize - 1];

    for (int i = 1; i <= maxDay; i++) {
        dp[i] = dp[i - 1]; 
        int needTicket = 0;
        for (int j = 0; j < daysSize; j++) {
            if (days[j] == i) {
                needTicket = 1;
                break;
            }
        }

        if (needTicket) {
            int cost1 = dp[i - 1] + costs[0];
            int cost7 = (i >= 7) ? dp[i - 7] + costs[1] : costs[1];
            int cost30 = (i >= 30) ? dp[i - 30] + costs[2] : costs[2];

            dp[i] = cost1;
            if (cost7 < dp[i]) dp[i] = cost7;
            if (cost30 < dp[i]) dp[i] = cost30;
        }
    }

    return dp[maxDay];
}