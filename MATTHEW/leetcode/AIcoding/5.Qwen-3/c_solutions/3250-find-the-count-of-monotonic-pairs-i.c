#include <stdio.h>
#include <stdlib.h>

long long countMonotonicPairs(int n, int a[]) {
    long long count = 0;
    int* dp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = 1;
        for (int j = 0; j < i; j++) {
            if (a[j] <= a[i]) {
                dp[i] += dp[j];
            }
        }
        count += dp[i];
    }
    free(dp);
    return count;
}