#include <stdlib.h>
#include <string.h>
#include <math.h>

double* dicesProbability(int n, int* returnSize) {
    int maxSum = 6 * n;
    int minSum = n;
    int rangeSize = maxSum - minSum + 1;

    int dp_size = maxSum + 1;
    int* dp = (int*)calloc(dp_size, sizeof(int));
    if (dp == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 1; i <= 6; ++i) {
        dp[i] = 1;
    }

    for (int i = 2; i <= n; ++i) {
        for (int j = 6 * i; j >= i; --j) {
            dp[j] = 0;
            for (int face = 1; face <= 6; ++face) {
                if (j - face >= (i - 1) && j - face <= 6 * (i - 1)) {
                    dp[j] += dp[j - face];
                }
            }
        }
    }

    double totalOutcomes = 1.0;
    for (int i = 0; i < n; ++i) {
        totalOutcomes *= 6.0;
    }

    *returnSize = rangeSize;
    double* result = (double*)malloc(rangeSize * sizeof(double));
    if (result == NULL) {
        free(dp);
        *returnSize = 0;
        return NULL;
    }

    int resultIdx = 0;
    for (int j = minSum; j <= maxSum; ++j) {
        result[resultIdx++] = (double)dp[j] / totalOutcomes;
    }

    free(dp);

    return result;
}