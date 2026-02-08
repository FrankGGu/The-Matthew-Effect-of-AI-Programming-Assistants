#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[1] != y[1]) return x[1] - y[1];
    return x[0] - y[0];
}

int maxEvents(int** events, int eventsSize, int* eventsColSize, int k) {
    qsort(events, eventsSize, sizeof(int*), compare);

    int n = eventsSize;
    int dp[k+1][n+1];
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= k; i++) {
        for (int j = 1; j <= n; j++) {
            int no = dp[i][j-1];
            int yes = 1 + dp[i-1][j-1];
            int prev = -1;
            for (int l = 0; l < j-1; l++) {
                if (events[l][1] < events[j-1][0]) {
                    prev = l;
                }
            }
            if (prev != -1) {
                yes = 1 + dp[i-1][prev+1];
            }
            dp[i][j] = (no > yes) ? no : yes;
        }
    }

    return dp[k][n];
}