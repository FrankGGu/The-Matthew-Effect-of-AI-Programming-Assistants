#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getLengthOfOptimalCompression(char* s, int k) {
    int n = strlen(s);
    int dp[101][101] = {0};

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 1000;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = dp[i - 1][j] + 1;
            if (j > 0) {
                dp[i][j] = fmin(dp[i][j], dp[i - 1][j - 1]);
            }

            for (int l = i - 1; l > 0 && j - (i - l) >= 0; l--) {
                int cnt = 1;
                for (int m = l + 1; m < i; m++) {
                    if (s[m] == s[l]) {
                        cnt++;
                    } else {
                        break;
                    }
                }
                if (j - (i - l) >= 0) {
                    dp[i][j] = fmin(dp[i][j], dp[l - 1][j - (i - l)] + (cnt >= 10 ? 2 : (cnt >= 100 ? 3 : 1)));
                }
            }
        }
    }

    return dp[n][k];
}