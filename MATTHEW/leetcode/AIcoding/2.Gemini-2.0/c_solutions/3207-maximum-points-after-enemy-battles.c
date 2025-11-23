#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int solve(int i, int j, int k, int l, int** dp, int* a, int* b, int n) {
    if (i == n) return 0;

    if (dp[i][l] != -1) return dp[i][l];

    int ans = 0;

    // Skip enemy
    ans = solve(i + 1, j, k, 0, dp, a, b, n);

    // Fight enemy
    if (l == 0 && a[i] >= b[i]) {
        ans = max(ans, a[i] - b[i] + solve(i + 1, j, k, 1, dp, a, b, n));
    }

    // Use j soldiers
    if (j > 0) {
        ans = max(ans, a[i] + solve(i + 1, j - 1, k, 0, dp, a, b, n));
    }

    // Use k soldiers
    if (k > 0) {
        ans = max(ans, b[i] + solve(i + 1, j, k - 1, 0, dp, a, b, n));
    }

    return dp[i][l] = ans;
}

int maxPointsAfterRemovingAdversaries(int* a, int aSize, int* b, int bSize, int j, int k){
    int** dp = (int**)malloc(aSize * sizeof(int*));
    for (int i = 0; i < aSize; i++) {
        dp[i] = (int*)malloc(2 * sizeof(int));
        for (int l = 0; l < 2; l++) {
            dp[i][l] = -1;
        }
    }

    int ans = solve(0, j, k, 0, dp, a, b, aSize);

    for (int i = 0; i < aSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return ans;
}