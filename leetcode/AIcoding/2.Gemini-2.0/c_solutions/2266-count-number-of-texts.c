#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countTexts(char *pressedKeys) {
    int n = strlen(pressedKeys);
    long long dp[n + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;
    int mod = 1000000007;

    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        if (i >= 2 && pressedKeys[i - 1] == pressedKeys[i - 2]) {
            dp[i] = (dp[i] + dp[i - 2]) % mod;
            if (i >= 3 && pressedKeys[i - 1] == pressedKeys[i - 3]) {
                dp[i] = (dp[i] + dp[i - 3]) % mod;
                if ((pressedKeys[i - 1] == '7' || pressedKeys[i - 1] == '9') && i >= 4 && pressedKeys[i - 1] == pressedKeys[i - 4]) {
                    dp[i] = (dp[i] + dp[i - 4]) % mod;
                }
            }
        }
    }

    return (int)dp[n];
}