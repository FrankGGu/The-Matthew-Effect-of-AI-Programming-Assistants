#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve(int n, int last_digit, int*** dp) {
    if (n == 0) {
        return 1;
    }

    if (dp[n][last_digit] != NULL) {
        return *dp[n][last_digit];
    }

    int count = 0;
    if (last_digit == 0) {
        count = solve(n - 1, 1, dp);
    } else {
        count = solve(n - 1, 0, dp) + solve(n - 1, 1, dp);
    }

    int* result = (int*)malloc(sizeof(int));
    *result = count;
    dp[n][last_digit] = result;

    return count;
}

int countBinaryStrings(int n) {
    int*** dp = (int***)malloc((n + 1) * sizeof(int**));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int**)malloc(2 * sizeof(int*));
        dp[i][0] = NULL;
        dp[i][1] = NULL;
    }

    int result = solve(n - 1, 0, dp) + solve(n - 1, 1, dp);

    for (int i = 0; i <= n; i++) {
        if (dp[i][0] != NULL) free(dp[i][0]);
        if (dp[i][1] != NULL) free(dp[i][1]);
        free(dp[i]);
    }
    free(dp);

    return result;
}