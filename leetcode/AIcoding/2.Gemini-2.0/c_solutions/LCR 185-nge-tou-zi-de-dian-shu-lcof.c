#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double* statisticalResult(int rollsSize, int* rolls, int target, int* returnSize) {
    int min_sum = rollsSize;
    int max_sum = 6 * rollsSize;

    if (target < min_sum || target > max_sum) {
        *returnSize = 0;
        return NULL;
    }

    int count = 0;
    for (int i = 0; i < rollsSize; i++) {
        if (rolls[i] >= 1 && rolls[i] <= 6) {
            count++;
        }
    }

    if (count != rollsSize) {
        *returnSize = 0;
        return NULL;
    }

    double* dp = (double*)malloc((max_sum + 1) * sizeof(double));
    for (int i = 0; i <= max_sum; i++) {
        dp[i] = 0.0;
    }

    for (int i = 1; i <= 6; i++) {
        dp[i] = 1.0;
    }

    for (int i = 2; i <= rollsSize; i++) {
        double* temp_dp = (double*)malloc((max_sum + 1) * sizeof(double));
        for (int j = 0; j <= max_sum; j++) {
            temp_dp[j] = 0.0;
        }

        for (int j = i; j <= 6 * i; j++) {
            for (int k = 1; k <= 6 && k < j; k++) {
                temp_dp[j] += dp[j - k];
            }
             if (j <=6)
                temp_dp[j] = 1;
             else{
                for (int k = 1; k <= 6; k++) {
                   if(j-k >= i-1 && j-k >= 1){
                        temp_dp[j] += dp[j - k];
                   }

                }
             }
        }
        free(dp);
        dp = temp_dp;
    }

    *returnSize = 1;
    double* result = (double*)malloc(sizeof(double));
    result[0] = dp[target] / pow(6.0, rollsSize);

    free(dp);
    return result;
}