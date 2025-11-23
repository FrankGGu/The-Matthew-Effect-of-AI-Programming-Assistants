#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxEqualSubstrings(char* s, int k, char* t) {
    int n = strlen(s);
    int m = strlen(t);
    int max_len = 0;
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    memset(dp, 0, (n + 1) * sizeof(int));

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            if (s[i - 1] == t[j - 1]) {
                dp[j] = dp[j - 1] + 1;
                if (dp[j] >= k) {
                    max_len = fmax(max_len, dp[j]);
                }
            } else {
                dp[j] = 0;
            }
        }
    }

    free(dp);
    return max_len;
}