#include <stdio.h>
#include <stdlib.h>

int colorTheGrid(int* dims, int dimsSize) {
    int m = dims[0], n = dims[1];
    int dp[2][3][3];
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            dp[0][i][j] = 1;
        }
    }
    for (int col = 1; col < n; col++) {
        for (int prev1 = 0; prev1 < 3; prev1++) {
            for (int prev2 = 0; prev2 < 3; prev2++) {
                if (prev1 != prev2) {
                    dp[1][prev1][prev2] = 0;
                    for (int curr1 = 0; curr1 < 3; curr1++) {
                        if (curr1 != prev1) {
                            for (int curr2 = 0; curr2 < 3; curr2++) {
                                if (curr2 != prev2 && curr1 != curr2) {
                                    dp[1][prev1][prev2] += dp[0][curr1][curr2];
                                }
                            }
                        }
                    }
                }
            }
        }
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                dp[0][i][j] = dp[1][i][j];
                dp[1][i][j] = 0;
            }
        }
    }
    int result = 0;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            result += dp[0][i][j];
        }
    }
    return result;
}