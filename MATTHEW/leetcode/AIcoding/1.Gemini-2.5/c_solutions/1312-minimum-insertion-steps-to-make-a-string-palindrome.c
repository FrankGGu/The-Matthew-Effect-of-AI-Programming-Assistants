#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int minInsertions(char * s){
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    char *s_rev = (char *)malloc(sizeof(char) * (n + 1));
    for (int i = 0; i < n; i++) {
        s_rev[i] = s[n - 1 - i];
    }
    s_rev[n] = '\0';

    int **dp = (int **)malloc(sizeof(int *) * (n + 1));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int *)malloc(sizeof(int) * (n + 1));
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            if (s[i - 1] == s_rev[j - 1]) {
                dp[i][j] = 1 + dp[i - 1][j - 1];
            } else {
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]);
            }
        }
    }

    int lcs_length = dp[n][n];

    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);
    free(s_rev);

    return n - lcs_length;
}