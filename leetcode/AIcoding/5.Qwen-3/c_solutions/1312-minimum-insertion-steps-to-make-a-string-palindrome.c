#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minInsertions(char* s) {
    int n = strlen(s);
    char* rev = (char*)malloc((n + 1) * sizeof(char));
    strcpy(rev, s);
    for (int i = 0; i < n / 2; i++) {
        char temp = rev[i];
        rev[i] = rev[n - 1 - i];
        rev[n - 1 - i] = temp;
    }

    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
    }

    for (int i = 0; i <= n; i++) {
        dp[i][0] = 0;
        dp[0][i] = 0;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            if (s[i - 1] == rev[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
            } else {
                dp[i][j] = fmax(dp[i - 1][j], dp[i][j - 1]);
            }
        }
    }

    int lcs = dp[n][n];
    free(rev);
    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);
    return n - lcs;
}