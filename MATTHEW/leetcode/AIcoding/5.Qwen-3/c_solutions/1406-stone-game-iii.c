#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* stoneGameIII(int* stoneValue, int stoneValueSize) {
    int n = stoneValueSize;
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    memset(dp, 0, (n + 1) * sizeof(int));

    for (int i = n - 1; i >= 0; i--) {
        dp[i] = stoneValue[i] - dp[i + 1];
        if (i + 1 < n) {
            dp[i] = fmax(dp[i], stoneValue[i] + stoneValue[i + 1] - dp[i + 2]);
        }
        if (i + 2 < n) {
            dp[i] = fmax(dp[i], stoneValue[i] + stoneValue[i + 1] + stoneValue[i + 2] - dp[i + 3]);
        }
    }

    char* result = (char*)malloc(10 * sizeof(char));
    if (dp[0] > 0) {
        strcpy(result, "Alice");
    } else if (dp[0] < 0) {
        strcpy(result, "Bob");
    } else {
        strcpy(result, "Tie");
    }

    free(dp);
    return result;
}