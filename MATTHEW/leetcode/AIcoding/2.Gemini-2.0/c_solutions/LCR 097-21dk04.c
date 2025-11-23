#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numDistinct(char * s, char * t){
    int sLen = 0, tLen = 0;
    while (s[sLen] != '\0') sLen++;
    while (t[tLen] != '\0') tLen++;

    long long dp[tLen + 1][sLen + 1];

    for (int i = 0; i <= tLen; i++) {
        for (int j = 0; j <= sLen; j++) {
            if (i == 0) {
                dp[i][j] = 1;
            } else if (j == 0) {
                dp[i][j] = 0;
            } else {
                if (t[i - 1] == s[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1] + dp[i][j - 1];
                } else {
                    dp[i][j] = dp[i][j - 1];
                }
            }
        }
    }

    return (int)dp[tLen][sLen];
}