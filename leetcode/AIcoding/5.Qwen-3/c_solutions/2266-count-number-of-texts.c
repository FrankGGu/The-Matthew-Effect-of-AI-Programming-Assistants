#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfTexts(char* s) {
    int n = strlen(s);
    long long dp[n + 1];
    dp[0] = 1;
    for (int i = 1; i <= n; i++) {
        dp[i] = 0;
        if (i - 1 >= 0 && s[i - 1] != ' ') {
            dp[i] += dp[i - 1];
        }
        if (i - 2 >= 0 && s[i - 2] == s[i - 1] && s[i - 1] != ' ') {
            dp[i] += dp[i - 2];
        }
        if (i - 3 >= 0 && s[i - 3] == s[i - 2] && s[i - 2] == s[i - 1] && s[i - 1] != ' ') {
            dp[i] += dp[i - 3];
        }
    }
    return dp[n];
}