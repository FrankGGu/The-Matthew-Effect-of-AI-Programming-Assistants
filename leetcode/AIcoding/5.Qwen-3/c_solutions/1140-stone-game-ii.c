#include <stdio.h>
#include <stdlib.h>

int dp[100][100];

int solve(int* prefix, int n, int i, int m) {
    if (i >= n) return 0;
    if (dp[i][m] != -1) return dp[i][m];
    int maxTake = 0;
    for (int x = 1; x <= 2 * m && i + x <= n; x++) {
        int newM = (m > x) ? m : x;
        int take = prefix[n] - prefix[i] - solve(prefix, n, i + x, newM);
        maxTake = (take > maxTake) ? take : maxTake;
    }
    dp[i][m] = maxTake;
    return maxTake;
}

int stoneGameII(int* piles, int pilesSize) {
    int n = pilesSize;
    int prefix[n + 1];
    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + piles[i];
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = -1;
        }
    }
    return solve(prefix, n, 0, 1);
}