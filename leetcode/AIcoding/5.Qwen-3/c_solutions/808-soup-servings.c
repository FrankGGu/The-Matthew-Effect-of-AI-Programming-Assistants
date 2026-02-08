#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double dp[200][200];

double solve(int n, int i, int j) {
    if (i >= n) return 1.0;
    if (j >= n) return 0.0;
    if (dp[i][j] > 0) return dp[i][j];
    double res = 0.25 * (solve(n, i + 4, j) + solve(n, i + 3, j) + solve(n, i + 2, j) + solve(n, i + 1, j));
    dp[i][j] = res;
    return res;
}

double soupServings(int n) {
    if (n <= 100) return solve(n, 0, 0);
    for (int i = 0; i < 200; i++) {
        for (int j = 0; j < 200; j++) {
            dp[i][j] = 0.0;
        }
    }
    return solve(n, 0, 0);
}