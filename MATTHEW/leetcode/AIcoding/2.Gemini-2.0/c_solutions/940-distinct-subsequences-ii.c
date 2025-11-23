#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distinctSubseqII(char * s){
    int n = strlen(s);
    int mod = 1000000007;
    int dp[n + 1];
    dp[0] = 1;
    int last[26];
    memset(last, -1, sizeof(last));

    for (int i = 1; i <= n; i++) {
        dp[i] = (2 * dp[i - 1]) % mod;
        int c = s[i - 1] - 'a';
        if (last[c] != -1) {
            dp[i] = (dp[i] - dp[last[c]] + mod) % mod;
        }
        last[c] = i - 1;
    }

    return (dp[n] - 1 + mod) % mod;
}