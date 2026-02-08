#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double** dp;
int* prefix;
int n, k;

double dfs(int i, int k) {
    if (i == n) return 0;
    if (k == 0) return -1e9;
    if (dp[i][k] != -1) return dp[i][k];

    double res = -1e9;
    for (int j = i; j < n; j++) {
        double avg = (prefix[j + 1] - prefix[i]) / (j - i + 1);
        double next = dfs(j + 1, k - 1);
        if (next != -1e9)
            res = fmax(res, avg + next);
    }
    dp[i][k] = res;
    return res;
}

double largestSumOfAverages(int* nums, int numsSize, int k) {
    n = numsSize;
    prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    dp = (double**)malloc(n * sizeof(double*));
    for (int i = 0; i < n; i++) {
        dp[i] = (double*)malloc((k + 1) * sizeof(double));
        for (int j = 0; j <= k; j++) {
            dp[i][j] = -1;
        }
    }

    double result = dfs(0, k);

    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);
    free(prefix);

    return result;
}