#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canCross(int* stones, int stonesSize) {
    if (stones[1] != 1) return false;

    bool** dp = (bool**)malloc(stonesSize * sizeof(bool*));
    for (int i = 0; i < stonesSize; i++) {
        dp[i] = (bool*)malloc(stonesSize * sizeof(bool));
        for (int j = 0; j < stonesSize; j++) {
            dp[i][j] = false;
        }
    }

    dp[1][1] = true;

    for (int i = 1; i < stonesSize; i++) {
        for (int j = 0; j < i; j++) {
            if (dp[i][j]) {
                for (int k = -1; k <= 1; k++) {
                    int nextJump = j + k;
                    if (nextJump > 0) {
                        for (int l = i + 1; l < stonesSize; l++) {
                            if (stones[l] == stones[i] + nextJump) {
                                dp[l][nextJump] = true;
                                if (l == stonesSize - 1) return true;
                            }
                        }
                    }
                }
            }
        }
    }

    for (int i = 0; i < stonesSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return false;
}