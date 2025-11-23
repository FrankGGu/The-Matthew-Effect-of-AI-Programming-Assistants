#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int stringCount(char *s, char *t) {
    int n = strlen(s);
    int m = strlen(t);
    int freq[26] = {0};
    for (int i = 0; i < m; i++) {
        freq[t[i] - 'a']++;
    }

    long long dp[n + 1][m + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            dp[i][j] = dp[i - 1][j];
            if (j > 0) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
            }
        }
    }

    long long ans = 0;
    for (int i = 1; i <= n; i++) {
        int count[26] = {0};
        for (int j = i; j <= n; j++) {
            count[s[j - 1] - 'a']++;
            int ok = 1;
            for (int k = 0; k < 26; k++) {
                if (count[k] < freq[k]) {
                    ok = 0;
                    break;
                }
            }
            if (ok) {
                ans = (ans + dp[j - i + 1][m]) % MOD;
            }
        }
    }

    return (int)ans;
}