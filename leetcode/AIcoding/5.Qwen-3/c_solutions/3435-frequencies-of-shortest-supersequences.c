#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numShortestSupersequences(char* s1, char* s2, int** result) {
    int m = strlen(s1), n = strlen(s2);
    int dp[m+1][n+1];
    int count[m+1][n+1];

    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            if (i == 0 && j == 0) {
                dp[i][j] = 0;
                count[i][j] = 1;
            } else if (i == 0) {
                dp[i][j] = j;
                count[i][j] = 1;
            } else if (j == 0) {
                dp[i][j] = i;
                count[i][j] = 1;
            } else {
                if (s1[i-1] == s2[j-1]) {
                    dp[i][j] = dp[i-1][j-1] + 1;
                    count[i][j] = count[i-1][j-1];
                } else {
                    dp[i][j] = 1 + fmin(dp[i-1][j], dp[i][j-1]);
                    count[i][j] = 0;
                    if (dp[i-1][j] == dp[i][j] - 1) {
                        count[i][j] += count[i-1][j];
                    }
                    if (dp[i][j-1] == dp[i][j] - 1) {
                        count[i][j] += count[i][j-1];
                    }
                }
            }
        }
    }

    *result = (int*)malloc(sizeof(int) * (dp[m][n] + 1));
    (*result)[0] = dp[m][n];
    return count[m][n];
}