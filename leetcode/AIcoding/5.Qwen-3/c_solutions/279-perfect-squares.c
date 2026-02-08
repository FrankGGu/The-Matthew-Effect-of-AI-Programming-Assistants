#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int numSquares(int n) {
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = n; // Max possible squares is n (1+1+...+1)
    }
    dp[0] = 0;
    for (int i = 1; i <= n; i++) {
        int j = 1;
        while (j * j <= i) {
            dp[i] = fmin(dp[i], dp[i - j * j] + 1);
            j++;
        }
    }
    int result = dp[n];
    free(dp);
    return result;
}