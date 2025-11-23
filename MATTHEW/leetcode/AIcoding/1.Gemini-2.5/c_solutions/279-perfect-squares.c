#include <stdlib.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int numSquares(int n) {
    int* dp = (int*)malloc((n + 1) * sizeof(int));

    dp[0] = 0;

    for (int i = 1; i <= n; ++i) {
        dp[i] = i; 
        for (int j = 1; j * j <= i; ++j) {
            dp[i] = min(dp[i], dp[i - j * j] + 1);
        }
    }

    int result = dp[n];
    free(dp);

    return result;
}