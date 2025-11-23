#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int freedomTrail(char * ring, char * key){
    int n = strlen(ring);
    int m = strlen(key);

    int **dp = (int **)malloc((m + 1) * sizeof(int *));
    for (int i = 0; i <= m; i++) {
        dp[i] = (int *)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dp[i][j] = 1e9;
        }
    }

    dp[0][0] = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (dp[i][j] != 1e9) {
                for (int k = 0; k < n; k++) {
                    if (ring[k] == key[i]) {
                        int diff = abs(j - k);
                        int cost = min(diff, n - diff);
                        dp[i + 1][k] = min(dp[i + 1][k], dp[i][j] + cost + 1);
                    }
                }
            }
        }
    }

    int ans = 1e9;
    for (int i = 0; i < n; i++) {
        ans = min(ans, dp[m][i]);
    }

    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);

    return ans;
}