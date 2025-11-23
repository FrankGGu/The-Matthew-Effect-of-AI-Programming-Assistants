#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* target, int targetSize, int* initial, int initialSize) {
    int n = targetSize;
    int m = initialSize;
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = 1e9;
    }
    dp[0] = 0;

    for (int i = 0; i < m; i++) {
        for (int j = n; j >= 1; j--) {
            if (initial[i] <= target[j - 1]) {
                dp[j] = (dp[j] < dp[j - 1] + 1) ? dp[j] : (dp[j - 1] + 1);
            }
        }
    }

    return n - dp[n];
}