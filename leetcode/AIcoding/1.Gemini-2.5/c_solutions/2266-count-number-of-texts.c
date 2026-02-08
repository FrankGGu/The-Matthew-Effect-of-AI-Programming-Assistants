#include <string.h>
#include <stdlib.h>

int countTexts(char *pressedKeys) {
    long long MOD = 1000000007;
    int n = strlen(pressedKeys);

    long long *dp = (long long *)malloc((n + 1) * sizeof(long long));

    dp[0] = 1;

    for (int i = 1; i <= n; ++i) {
        dp[i] = 0;

        dp[i] = (dp[i] + dp[i-1]) % MOD;

        if (i >= 2 && pressedKeys[i-1] == pressedKeys[i-2]) {
            dp[i] = (dp[i] + dp[i-2]) % MOD;

            if (i >= 3 && pressedKeys[i-1] == pressedKeys[i-3]) {
                dp[i] = (dp[i] + dp[i-3]) % MOD;

                if (i >= 4 && pressedKeys[i-1] == pressedKeys[i-4] &&
                    (pressedKeys[i-1] == '7' || pressedKeys[i-1] == '9')) {
                    dp[i] = (dp[i] + dp[i-4]) % MOD;
                }
            }
        }
    }

    long long result = dp[n];
    free(dp);
    return (int)result;
}