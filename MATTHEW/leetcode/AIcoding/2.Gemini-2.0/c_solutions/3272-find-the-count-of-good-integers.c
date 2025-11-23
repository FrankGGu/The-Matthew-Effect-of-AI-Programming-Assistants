#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dp[11][2][10];

int solve(char *s, int index, int tight, int prevDigit) {
    if (s[index] == '\0') {
        return 1;
    }

    if (dp[index][tight][prevDigit] != -1) {
        return dp[index][tight][prevDigit];
    }

    int ub = (tight) ? (s[index] - '0') : 9;
    int ans = 0;

    for (int digit = 0; digit <= ub; digit++) {
        if (abs(digit - prevDigit) != 1) {
            ans += solve(s, index + 1, tight && (digit == ub), digit);
        }
    }

    return dp[index][tight][prevDigit] = ans;
}

int countGoodIntegers(int n) {
    char s[11];
    sprintf(s, "%d", n);
    memset(dp, -1, sizeof(dp));

    int ans = 0;
    for (int digit = 1; digit <= (s[0] - '0'); digit++) {
        ans += solve(s, 1, (digit == (s[0] - '0')), digit);
    }

    return ans;
}