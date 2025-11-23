#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minValidStrings(char * word, char * target) {
    int n = strlen(word);
    int m = strlen(target);
    int *dp = (int *)malloc((m + 1) * sizeof(int));
    for (int i = 0; i <= m; i++) {
        dp[i] = 0;
    }
    for (int i = 1; i <= m; i++) {
        dp[i] = dp[i - 1] + 1;
        for (int j = 0; j < n; j++) {
            if (i >= n && strncmp(target + i - n, word, n) == 0) {
                dp[i] = (i == n) ? 1 : (dp[i] < dp[i - n] ? dp[i] : dp[i - n]);
                break;
            }
        }
    }
    int result = dp[m];
    free(dp);
    return result;
}