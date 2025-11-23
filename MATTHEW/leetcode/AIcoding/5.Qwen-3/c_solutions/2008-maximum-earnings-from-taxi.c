#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maxTaxiEarnings(int n, int** trips) {
    int* start = (int*)malloc(n * sizeof(int));
    int* end = (int*)malloc(n * sizeof(int));
    int* cost = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        start[i] = trips[i][0];
        end[i] = trips[i][1];
        cost[i] = trips[i][2];
    }

    qsort(start, n, sizeof(int), compare);
    qsort(end, n, sizeof(int), compare);

    long long* dp = (long long*)malloc((n + 1) * sizeof(long long));
    for (int i = 0; i <= n; i++) dp[i] = 0;

    int j = 0;
    for (int i = 0; i < n; i++) {
        while (j < n && end[j] < start[i]) j++;
        dp[i + 1] = (dp[i] > (dp[j] + cost[i])) ? dp[i] : (dp[j] + cost[i]);
    }

    long long result = dp[n];
    free(start);
    free(end);
    free(cost);
    free(dp);
    return result;
}