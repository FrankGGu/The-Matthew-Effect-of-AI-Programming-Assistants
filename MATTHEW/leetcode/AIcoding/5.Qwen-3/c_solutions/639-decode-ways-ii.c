#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numDecodings(char* s) {
    int n = strlen(s);
    long dp[101];
    dp[0] = 1;
    dp[1] = (s[0] == '*') ? 9 : (s[0] == '0') ? 0 : 1;

    for (int i = 2; i <= n; i++) {
        dp[i] = 0;
        if (s[i-1] == '*') {
            dp[i] += 9 * dp[i-1];
        } else if (s[i-1] > '0') {
            dp[i] += dp[i-1];
        }

        if (s[i-2] == '*') {
            if (s[i-1] == '*') {
                dp[i] += 15 * dp[i-2];
            } else if (s[i-1] <= '6') {
                dp[i] += 2 * dp[i-2];
            } else {
                dp[i] += dp[i-2];
            }
        } else if (s[i-2] == '1') {
            dp[i] += dp[i-2];
        } else if (s[i-2] == '2' && s[i-1] <= '6') {
            dp[i] += dp[i-2];
        }
    }

    return (int)dp[n];
}