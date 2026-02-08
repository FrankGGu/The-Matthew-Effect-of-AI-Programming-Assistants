#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numDecodings(char *s) {
    long long n = 0;
    while (s[n] != '\0') {
        n++;
    }

    long long mod = 1000000007;

    long long dp[n + 1];
    dp[0] = 1;
    dp[1] = (s[0] == '*') ? 9 : (s[0] == '0' ? 0 : 1);

    for (int i = 2; i <= n; i++) {
        dp[i] = 0;
        char one = s[i - 1];
        char two = s[i - 2];

        if (one == '*') {
            dp[i] = (dp[i] + 9 * dp[i - 1]) % mod;
        } else if (one != '0') {
            dp[i] = (dp[i] + dp[i - 1]) % mod;
        }

        if (two == '*') {
            if (one == '*') {
                dp[i] = (dp[i] + 15 * dp[i - 2]) % mod;
            } else {
                if (one >= '0' && one <= '6') {
                    dp[i] = (dp[i] + 2 * dp[i - 2]) % mod;
                } else {
                    dp[i] = (dp[i] + dp[i - 2]) % mod;
                }
            }
        } else if (two == '1') {
            if (one == '*') {
                dp[i] = (dp[i] + 9 * dp[i - 2]) % mod;
            } else {
                dp[i] = (dp[i] + dp[i - 2]) % mod;
            }
        } else if (two == '2') {
            if (one == '*') {
                dp[i] = (dp[i] + 6 * dp[i - 2]) % mod;
            } else if (one >= '0' && one <= '6') {
                dp[i] = (dp[i] + dp[i - 2]) % mod;
            }
        }
    }

    return (int)dp[n];
}