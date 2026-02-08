#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numDecodings(char * s){
    int n = strlen(s);
    if (n == 0 || s[0] == '0') return 0;
    if (n == 1) return 1;

    int dp[n + 1];
    dp[0] = 1;
    dp[1] = 1;

    for (int i = 2; i <= n; i++) {
        dp[i] = 0;
        int one_digit = s[i - 1] - '0';
        int two_digits = (s[i - 2] - '0') * 10 + one_digit;

        if (one_digit >= 1 && one_digit <= 9) {
            dp[i] += dp[i - 1];
        }
        if (two_digits >= 10 && two_digits <= 26) {
            dp[i] += dp[i - 2];
        }
    }

    return dp[n];
}