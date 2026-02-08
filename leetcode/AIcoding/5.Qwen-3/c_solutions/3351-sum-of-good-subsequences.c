#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumOfGoodSubsequences(char *s) {
    int n = strlen(s);
    int dp[26][26];
    memset(dp, 0, sizeof(dp));
    int total = 0;
    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        int sum = 0;
        for (int j = 0; j < 26; j++) {
            sum += dp[j][c];
        }
        total += sum;
        for (int j = 0; j < 26; j++) {
            dp[j][c] += dp[j][c];
        }
        for (int j = 0; j < 26; j++) {
            dp[c][j] += dp[c][j];
        }
        dp[c][c]++;
    }
    return total;
}