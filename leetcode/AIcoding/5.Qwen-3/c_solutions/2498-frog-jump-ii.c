#include <stdio.h>
#include <stdlib.h>

int canReach(int* stones, int stonesSize, int k) {
    int* dp = (int*)malloc(stonesSize * sizeof(int));
    for (int i = 0; i < stonesSize; i++) {
        dp[i] = 1;
    }

    for (int i = 1; i < stonesSize; i++) {
        for (int j = 0; j < i; j++) {
            int diff = stones[i] - stones[j];
            if (diff > k) continue;
            if (dp[j] + 1 <= k) {
                dp[i] = fmax(dp[i], dp[j] + 1);
            }
        }
    }

    int result = dp[stonesSize - 1] <= k;
    free(dp);
    return result;
}

int canCross(int* stones, int stonesSize) {
    return canReach(stones, stonesSize, 2);
}