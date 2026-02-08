#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numWays(int n, int** relation, int relationSize, int* relationColSize, int k) {
    int dp[k + 1][n];
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }
    dp[0][0] = 1;

    for (int i = 1; i <= k; i++) {
        for (int j = 0; j < relationSize; j++) {
            int src = relation[j][0];
            int dest = relation[j][1];
            dp[i][dest] += dp[i - 1][src];
        }
    }

    return dp[k][n - 1];
}