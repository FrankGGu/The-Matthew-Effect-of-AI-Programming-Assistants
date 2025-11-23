#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int solve() {
    int n;
    scanf("%d", &n);

    int *a = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        scanf("%d", &a + i);
    }

    long long dp[n + 1][2];
    dp[0][0] = 0;
    dp[0][1] = 0;

    for (int i = 1; i <= n; i++) {
        dp[i][0] = dp[i - 1][1] + a[i - 1];
        if (i >= 2) {
            dp[i][1] = min(dp[i - 1][0], dp[i - 2][0]) + a[i - 1];
        } else {
            dp[i][1] = dp[i-1][0] + a[i-1];
        }

    }

    long long result = min(dp[n][0], dp[n][1]);
    free(a);
    return result;
}