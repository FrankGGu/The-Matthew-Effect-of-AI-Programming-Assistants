#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mod = 1000000007;

int dp[101];

int solve(char *s, int i) {
    if (i == strlen(s)) return 1;
    if (dp[i] != -1) return dp[i];

    int res = 0;
    for (int j = i + 1; j <= strlen(s); j++) {
        char temp[11];
        strncpy(temp, s + i, j - i);
        temp[j - i] = '\0';
        long num = strtol(temp, NULL, 10);
        if (num > 0 && num <= 26) {
            res = (res + solve(s, j)) % mod;
        }
    }
    dp[i] = res;
    return res;
}

int numDecodings(char *s) {
    memset(dp, -1, sizeof(dp));
    return solve(s, 0);
}