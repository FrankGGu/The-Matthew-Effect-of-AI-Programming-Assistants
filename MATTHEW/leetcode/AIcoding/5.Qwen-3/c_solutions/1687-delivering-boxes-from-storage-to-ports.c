#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int port;
    int weight;
} Box;

int compare(const void *a, const void *b) {
    return ((Box*)a)->port - ((Box*)b)->port;
}

int boxDeliver(int** boxes, int boxesSize, int* boxesColSize, int n, int k) {
    int i, j, m = boxesSize;
    int* dp = (int*)malloc((m + 1) * sizeof(int));
    int* pre = (int*)malloc((m + 1) * sizeof(int));
    int* sum = (int*)malloc((m + 1) * sizeof(int));
    int* cost = (int*)malloc((m + 1) * sizeof(int));
    for (i = 0; i <= m; i++) {
        dp[i] = INT_MAX;
        pre[i] = 0;
        sum[i] = 0;
        cost[i] = 0;
    }
    dp[0] = 0;
    for (i = 1; i <= m; i++) {
        sum[i] = sum[i - 1] + boxes[i - 1][1];
        cost[i] = cost[i - 1] + (boxes[i - 1][0] != boxes[i - 2][0]);
    }
    for (i = 1; i <= m; i++) {
        pre[i] = pre[i - 1] + boxes[i - 1][1];
    }
    for (i = 1; i <= m; i++) {
        for (j = i; j >= 1 && j >= i - k; j--) {
            if (dp[j - 1] != INT_MAX) {
                int w = pre[i] - pre[j - 1];
                int c = cost[i] - cost[j - 1];
                dp[i] = (dp[i] > dp[j - 1] + c + 100) ? dp[j - 1] + c + 100 : dp[i];
            }
        }
    }
    return dp[m];
}