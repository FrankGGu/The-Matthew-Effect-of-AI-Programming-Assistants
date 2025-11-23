#include <stdio.h>
#include <stdlib.h>

int numPermutationsForDISequence(char* S) {
    int n = 0;
    while (S[n]) n++;

    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < i; j++) {
            if (S[i - 1] == 'D') {
                for (int k = j; k < i; k++) {
                    dp[i][k] += dp[i - 1][j];
                }
            } else {
                for (int k = j + 1; k < i; k++) {
                    dp[i][k] += dp[i - 1][j];
                }
            }
        }
    }

    int result = 0;
    for (int j = 0; j <= n; j++) {
        result += dp[n][j];
    }

    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}