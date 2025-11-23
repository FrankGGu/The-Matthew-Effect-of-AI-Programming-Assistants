#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMaxForm(char** strs, int strsSize, int m, int n) {
    int** dp = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
        memset(dp[i], 0, (n + 1) * sizeof(int));
    }

    for (int k = 0; k < strsSize; k++) {
        int zeros = 0;
        int ones = 0;
        for (int i = 0; strs[k][i] != '\0'; i++) {
            if (strs[k][i] == '0') {
                zeros++;
            } else {
                ones++;
            }
        }

        for (int i = m; i >= zeros; i--) {
            for (int j = n; j >= ones; j--) {
                dp[i][j] = (dp[i][j] > dp[i - zeros][j - ones] + 1) ? dp[i][j] : dp[i - zeros][j - ones] + 1;
            }
        }
    }

    int result = dp[m][n];

    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}