#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSquares(int n) {
    int* dp = (int*)malloc(sizeof(int) * (n + 1));
    for (int i = 0; i <= n; i++) {
        dp[i] = i;
    }

    for (int i = 2; i * i <= n; i++) {
        int square = i * i;
        for (int j = square; j <= n; j++) {
            dp[j] = (dp[j] < dp[j - square] + 1) ? dp[j] : dp[j - square] + 1;
        }
    }

    int result = dp[n];
    free(dp);
    return result;
}