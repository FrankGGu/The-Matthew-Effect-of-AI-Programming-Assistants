#include <string.h>
#include <limits.h>

int minCut(char* s) {
    int n = strlen(s);
    if (n <= 1) return 0;

    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = i - 1;
    }

    int** isPal = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        isPal[i] = (int*)malloc(n * sizeof(int));
        memset(isPal[i], 0, n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= i; j++) {
            if (s[i] == s[j] && (i - j <= 1 || isPal[j + 1][i - 1])) {
                isPal[j][i] = 1;
                if (j == 0) {
                    dp[i + 1] = 0;
                } else {
                    if (dp[i + 1] > dp[j] + 1) {
                        dp[i + 1] = dp[j] + 1;
                    }
                }
            }
        }
    }

    int result = dp[n];

    for (int i = 0; i < n; i++) {
        free(isPal[i]);
    }
    free(isPal);
    free(dp);

    return result;
}