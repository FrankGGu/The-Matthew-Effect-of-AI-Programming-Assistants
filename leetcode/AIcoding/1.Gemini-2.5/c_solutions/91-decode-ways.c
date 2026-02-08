#include <string.h>

int numDecodings(char *s) {
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    int dp[n + 1];
    dp[0] = 1;
    dp[1] = (s[0] == '0') ? 0 : 1;

    for (int i = 2; i <= n; i++) {
        dp[i] = 0;

        // Check for single digit decoding
        if (s[i - 1] != '0') {
            dp[i] += dp[i - 1];
        }

        // Check for two digit decoding
        if (s[i - 2] == '1' || (s[i - 2] == '2' && s[i - 1] >= '0' && s[i - 1] <= '6')) {
            dp[i] += dp[i - 2];
        }
    }

    return dp[n];
}