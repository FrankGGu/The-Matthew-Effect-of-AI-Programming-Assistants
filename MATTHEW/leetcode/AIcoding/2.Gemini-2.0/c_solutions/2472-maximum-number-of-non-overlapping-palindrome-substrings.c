#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxNonOverlapping(char * s) {
    int n = strlen(s);
    bool dp[n][n];
    memset(dp, false, sizeof(dp));

    for (int i = 0; i < n; i++) {
        dp[i][i] = true;
    }

    for (int i = 0; i < n - 1; i++) {
        if (s[i] == s[i + 1]) {
            dp[i][i + 1] = true;
        }
    }

    for (int len = 3; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (s[i] == s[j] && dp[i + 1][j - 1]) {
                dp[i][j] = true;
            }
        }
    }

    int count = 0;
    int last = -1;
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            if (dp[i][j] && (last == -1 || i > last)) {
                count++;
                last = j;
                break;
            }
        }
    }

    return count;
}