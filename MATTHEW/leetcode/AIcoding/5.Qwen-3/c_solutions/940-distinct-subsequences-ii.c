#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countDistinctSubseqII(char* s) {
    int mod = 1000000007;
    int n = strlen(s);
    long long dp[n + 1];
    dp[0] = 1;
    long long last[26] = {0};

    for (int i = 1; i <= n; i++) {
        dp[i] = (dp[i - 1] * 2) % mod;
        int idx = s[i - 1] - 'a';
        if (last[idx] > 0) {
            dp[i] = (dp[i] - dp[last[idx] - 1] + mod) % mod;
        }
        last[idx] = i;
    }

    return (int)(dp[n] - 1);
}