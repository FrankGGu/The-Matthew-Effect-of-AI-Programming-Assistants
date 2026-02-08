#include <stdlib.h>
#include <stdbool.h>

bool canCross(int* stones, int stonesSize) {
    if (stonesSize < 2 || stones[0] != 0 || stones[1] != 1) {
        return false;
    }

    int** dp = (int**)malloc(stonesSize * sizeof(int*));
    for (int i = 0; i < stonesSize; i++) {
        dp[i] = (int*)calloc(stonesSize, sizeof(int));
    }
    dp[0][0] = 1;

    for (int i = 1; i < stonesSize; i++) {
        for (int j = i - 1; j >= 0; j--) {
            int diff = stones[i] - stones[j];
            if (diff > j + 1) {
                break;
            }
            if (dp[j][diff - 1] || dp[j][diff] || (diff + 1 < stonesSize && dp[j][diff + 1])) {
                dp[i][diff] = 1;
                if (i == stonesSize - 1) {
                    for (int k = 0; k < stonesSize; k++) free(dp[k]);
                    free(dp);
                    return true;
                }
            }
        }
    }

    bool result = false;
    for (int k = 0; k < stonesSize; k++) {
        if (dp[stonesSize - 1][k]) {
            result = true;
            break;
        }
    }

    for (int i = 0; i < stonesSize; i++) free(dp[i]);
    free(dp);
    return result;
}