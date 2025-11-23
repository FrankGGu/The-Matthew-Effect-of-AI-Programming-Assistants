#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return ((int*)a)[0] - ((int*)b)[0];
}

int maximizeTheProfit(int n, int** offers, int offersSize, int* offersColSize) {
    qsort(offers, offersSize, sizeof(offers[0]), cmp);

    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = 0;
    }

    int offerIndex = 0;
    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        while (offerIndex < offersSize && offers[offerIndex][0] == i - 1) {
            int start = offers[offerIndex][0];
            int end = offers[offerIndex][1];
            int gold = offers[offerIndex][2];
            if (end + 1 <= n) {
                dp[end + 1] = (dp[end + 1] > dp[i - 1] + gold) ? dp[end + 1] : (dp[i - 1] + gold);
            } else {
                dp[n] = (dp[n] > dp[i - 1] + gold) ? dp[n] : (dp[i - 1] + gold);
            }
            offerIndex++;
        }
    }

    return dp[n];
}