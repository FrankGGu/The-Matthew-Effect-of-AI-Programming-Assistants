#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countDifferentSubsequences(char *s) {
    int mod = 1000000007;
    int n = strlen(s);
    int dp[26] = {0};
    int total = 0;
    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        int prev = dp[c];
        dp[c] = (total + 1) % mod;
        total = (total + dp[c] - prev) % mod;
    }
    return total;
}