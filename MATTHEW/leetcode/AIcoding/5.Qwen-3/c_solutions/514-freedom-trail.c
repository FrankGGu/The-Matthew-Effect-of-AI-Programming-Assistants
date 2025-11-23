#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findRotateSteps(char *ring, char *key) {
    int n = strlen(ring);
    int m = strlen(key);
    int** dp = (int**)malloc(sizeof(int*) * m);
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(sizeof(int) * n);
    }
    for (int i = 0; i < n; i++) {
        dp[0][i] = (abs(i - 0) < (n - abs(i - 0))) ? abs(i - 0) : (n - abs(i - 0));
        if (ring[i] == key[0]) {
            dp[0][i] = 0;
        }
    }
    for (int i = 1; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (ring[j] != key[i]) {
                dp[i][j] = INT_MAX;
                continue;
            }
            for (int k = 0; k < n; k++) {
                if (dp[i - 1][k] == INT_MAX) continue;
                int steps = (abs(j - k) < (n - abs(j - k))) ? abs(j - k) : (n - abs(j - k));
                dp[i][j] = (dp[i][j] < dp[i - 1][k] + steps + 1) ? dp[i][j] : dp[i - 1][k] + steps + 1;
            }
        }
    }
    int result = INT_MAX;
    for (int i = 0; i < n; i++) {
        if (dp[m - 1][i] < result) {
            result = dp[m - 1][i];
        }
    }
    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}