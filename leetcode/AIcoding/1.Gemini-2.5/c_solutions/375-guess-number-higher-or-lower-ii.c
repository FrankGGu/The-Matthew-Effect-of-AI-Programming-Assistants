#include <stdlib.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int getMoneyAmount(int n) {
    if (n == 1) {
        return 0;
    }

    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 1; i <= n - length + 1; i++) {
            int j = i + length - 1;
            dp[i][j] = INT_MAX;

            for (int k = i; k <= j; k++) {
                int cost_if_guess_k = k + max(
                    (k > i ? dp[i][k-1] : 0),
                    (k < j ? dp[k+1][j] : 0)
                );
                dp[i][j] = (dp[i][j] < cost_if_guess_k) ? dp[i][j] : cost_if_guess_k;
            }
        }
    }

    int result = dp[1][n];

    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}