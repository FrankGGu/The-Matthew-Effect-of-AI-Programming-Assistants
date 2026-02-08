#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int parallelCourses(int n, int** relations, int relationsSize, int* relationsColSize, int k) {
    int* inDegree = (int*)calloc(n, sizeof(int));
    int* preMask = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < relationsSize; i++) {
        int pre = relations[i][0] - 1;
        int next = relations[i][1] - 1;
        inDegree[next]++;
        preMask[next] |= (1 << pre);
    }

    int* dp = (int*)malloc((1 << n) * sizeof(int));
    for (int i = 0; i < (1 << n); i++) {
        dp[i] = n + 1;
    }
    dp[0] = 0;

    for (int mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] == n + 1) continue;

        int available = 0;
        for (int i = 0; i < n; i++) {
            if (!(mask & (1 << i)) && (preMask[i] & mask) == preMask[i]) {
                available |= (1 << i);
            }
        }

        for (int submask = available; submask > 0; submask = (submask - 1) & available) {
            if (__builtin_popcount(submask) <= k) {
                dp[mask | submask] = min(dp[mask | submask], dp[mask] + 1);
            }
        }
    }

    int result = dp[(1 << n) - 1];
    free(inDegree);
    free(preMask);
    free(dp);
    return result;
}