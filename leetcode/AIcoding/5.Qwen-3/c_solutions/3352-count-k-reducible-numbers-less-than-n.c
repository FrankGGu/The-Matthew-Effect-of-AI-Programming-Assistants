#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int countKReducibleNumbers(int N, int K) {
    if (N == 0) return 0;
    int* dp = (int*)malloc((N + 1) * sizeof(int));
    dp[0] = 0;
    for (int i = 1; i <= N; i++) {
        dp[i] = 0;
        for (int j = 1; j <= i; j++) {
            if (i % j == 0) {
                if (j >= K) {
                    dp[i] += dp[i / j];
                }
            }
        }
    }
    int result = 0;
    for (int i = 1; i <= N; i++) {
        if (dp[i] > 0) {
            result++;
        }
    }
    free(dp);
    return result;
}