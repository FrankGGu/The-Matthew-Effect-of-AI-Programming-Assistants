#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countKSubsequence(char *s, int k) {
    int n = strlen(s);
    long long mod = 1000000007;
    long long dp[26][k+1];
    long long freq[26] = {0};

    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (freq[i] == 0) continue;
        for (int j = 0; j <= k; j++) {
            if (j == 0) {
                dp[i][j] = 1;
            } else {
                dp[i][j] = dp[i-1][j];
                if (j >= 1) {
                    dp[i][j] = (dp[i][j] + dp[i-1][j-1] * freq[i]) % mod;
                }
            }
        }
    }

    return dp[25][k];
}