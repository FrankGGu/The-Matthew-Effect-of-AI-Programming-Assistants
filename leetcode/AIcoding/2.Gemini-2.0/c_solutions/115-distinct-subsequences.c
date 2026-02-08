#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numDistinct(char * s, char * t){
    int sLen = strlen(s);
    int tLen = strlen(t);

    if (tLen > sLen) {
        return 0;
    }

    unsigned long long dp[tLen + 1][sLen + 1];

    for (int i = 0; i <= sLen; i++) {
        dp[0][i] = 1;
    }

    for (int i = 1; i <= tLen; i++) {
        dp[i][0] = 0;
    }

    for (int i = 1; i <= tLen; i++) {
        for (int j = 1; j <= sLen; j++) {
            if (t[i - 1] == s[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + dp[i][j - 1];
            } else {
                dp[i][j] = dp[i][j - 1];
            }
        }
    }

    return (int)dp[tLen][sLen];
}