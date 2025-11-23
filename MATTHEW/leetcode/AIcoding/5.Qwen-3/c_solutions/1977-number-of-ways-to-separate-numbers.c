#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countWays(char* s) {
    int n = strlen(s);
    long long dp[n + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < i; j++) {
            if (dp[j] == 0) continue;
            char* sub = (char*)malloc(i - j + 1);
            strncpy(sub, s + j, i - j);
            sub[i - j] = '\0';
            if (sub[0] == '0' && i - j > 1) {
                free(sub);
                continue;
            }
            long long num = atoll(sub);
            if (num > 1e18) {
                free(sub);
                continue;
            }
            dp[i] += dp[j];
            free(sub);
        }
    }
    return dp[n];
}

long long numberOfWays(char* s) {
    return countWays(s);
}