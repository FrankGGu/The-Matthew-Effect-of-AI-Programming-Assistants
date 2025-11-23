#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int boxDelivering(int** boxes, int boxesSize, int* boxesColSize, int portsCount, int maxBoxes, int maxWeight) {
    int n = boxesSize;
    int* w = (int*)malloc((n + 1) * sizeof(int));
    int* p = (int*)malloc((n + 1) * sizeof(int));
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    w[0] = 0;
    p[0] = 0;
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        w[i + 1] = w[i] + boxes[i][1];
        p[i + 1] = boxes[i][0];
    }

    for (int i = 1; i <= n; i++) {
        dp[i] = INT_MAX;
        int weight = 0;
        int trips = 1;
        for (int j = i; j >= 1 && (i - j + 1) <= maxBoxes; j--) {
            weight += boxes[j - 1][1];
            if (weight > maxWeight) break;
            if (j < i && p[j] != p[j + 1]) trips++;
            if (dp[j - 1] != INT_MAX && dp[j - 1] + trips < dp[i]) {
                dp[i] = dp[j - 1] + trips;
            }
        }
    }

    free(w);
    free(p);
    return dp[n];
}