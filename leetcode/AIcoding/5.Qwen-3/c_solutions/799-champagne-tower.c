#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double champagneTower(int poured, int query_row, int query_glass) {
    double** dp = (double**)malloc((query_row + 2) * sizeof(double*));
    for (int i = 0; i <= query_row + 1; i++) {
        dp[i] = (double*)calloc(i + 1, sizeof(double));
    }
    dp[0][0] = poured;
    for (int row = 0; row <= query_row; row++) {
        for (int glass = 0; glass <= row; glass++) {
            if (dp[row][glass] > 1.0) {
                double overflow = dp[row][glass] - 1.0;
                dp[row + 1][glass] += overflow / 2.0;
                dp[row + 1][glass + 1] += overflow / 2.0;
                dp[row][glass] = 1.0;
            }
        }
    }
    double result = dp[query_row][query_glass];
    for (int i = 0; i <= query_row + 1; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}