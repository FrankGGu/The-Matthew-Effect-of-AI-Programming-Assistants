#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minChanges(char* s, int k) {
    int n = strlen(s);
    int** dp = (int**)malloc(k * sizeof(int*));
    for (int i = 0; i < k; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
        memset(dp[i], -1, (n + 1) * sizeof(int));
    }

    int** cost = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        cost[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int len = j - i + 1;
            int changes = 0;
            for (int l = 0; l < len / 2; l++) {
                if (s[i + l] != s[j - l]) {
                    changes++;
                }
            }
            cost[i][j] = changes;
        }
    }

    for (int i = 0; i < n; i++) {
        dp[0][i] = cost[0][i];
    }

    for (int m = 1; m < k; m++) {
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                if (j - i + 1 < m) continue;
                int min_val = INT_MAX;
                for (int p = 0; p < m; p++) {
                    if (i - 1 >= 0 && dp[p][i - 1] != -1) {
                        int current = dp[p][i - 1] + cost[i][j];
                        if (current < min_val) {
                            min_val = current;
                        }
                    }
                }
                dp[m][j] = min_val;
            }
        }
    }

    int result = INT_MAX;
    for (int i = 0; i < n; i++) {
        if (dp[k - 1][i] != -1) {
            if (dp[k - 1][i] < result) {
                result = dp[k - 1][i];
            }
        }
    }

    for (int i = 0; i < k; i++) {
        free(dp[i]);
    }
    free(dp);
    for (int i = 0; i < n; i++) {
        free(cost[i]);
    }
    free(cost);

    return result;
}