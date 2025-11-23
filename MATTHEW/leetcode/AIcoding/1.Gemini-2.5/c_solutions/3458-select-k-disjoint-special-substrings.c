#include <string.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int selectKDisjointSpecialSubstrings(char* s, int k) {
    if (s == NULL || k == 0) {
        return 0;
    }

    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    if (dp == NULL) return 0;

    for (int i = 0; i <= n; ++i) {
        dp[i] = (int*)malloc((k + 1) * sizeof(int));
        if (dp[i] == NULL) {
            for (int x = 0; x < i; ++x) {
                free(dp[x]);
            }
            free(dp);
            return 0;
        }
        for (int j = 0; j <= k; ++j) {
            dp[i][j] = 0;
        }
    }

    int* balance = (int*)malloc((n + 1) * sizeof(int));
    if (balance == NULL) {
        for (int i = 0; i <= n; ++i) {
            free(dp[i]);
        }
        free(dp);
        return 0;
    }
    balance[0] = 0;
    for (int i = 0; i < n; ++i) {
        balance[i+1] = balance[i] + (s[i] == '1' ? 1 : -1);
    }

    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= k; ++j) {
            dp[i][j] = dp[i-1][j];

            for (int p = 0; p < i; ++p) {
                if (balance[i] == balance[p]) {
                    dp[i][j] = max(dp[i][j], dp[p][j-1] + (i - p));
                }
            }
        }
    }

    int result = dp[n][k];

    for (int i = 0; i <= n; ++i) {
        free(dp[i]);
    }
    free(dp);
    free(balance);

    return result;
}