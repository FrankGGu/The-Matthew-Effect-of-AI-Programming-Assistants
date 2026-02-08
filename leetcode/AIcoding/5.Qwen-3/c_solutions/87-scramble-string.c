#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isScramble(char* s1, char* s2) {
    int n = strlen(s1);
    if (n != strlen(s2)) return false;
    if (n == 0) return true;

    bool*** dp = (bool***)malloc(n * sizeof(bool**));
    for (int i = 0; i < n; i++) {
        dp[i] = (bool**)malloc(n * sizeof(bool*));
        for (int j = 0; j < n; j++) {
            dp[i][j] = (bool*)malloc(n * sizeof(bool));
            memset(dp[i][j], false, n * sizeof(bool));
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[0][i][j] = (s1[i] == s2[j]);
        }
    }

    for (int l = 2; l <= n; l++) {
        for (int i = 0; i <= n - l; i++) {
            for (int j = 0; j <= n - l; j++) {
                for (int k = 1; k < l; k++) {
                    if ((dp[k][i][j] && dp[l - k][i + k][j + k]) ||
                        (dp[k][i][j + l - k] && dp[l - k][i + k][j])) {
                        dp[l][i][j] = true;
                        break;
                    }
                }
            }
        }
    }

    bool result = dp[n][0][0];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return result;
}