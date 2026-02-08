#include <stdlib.h>
#include <string.h>

int numberOfArithmeticSlices(int* nums, int numsSize) {
    if (numsSize < 3) return 0;

    int total = 0;
    long diff;
    int** dp = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = (int*)calloc(numsSize, sizeof(int));
    }

    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            diff = (long)nums[i] - (long)nums[j];
            if (diff < INT_MIN || diff > INT_MAX) continue;

            dp[i][j] = 1;
            for (int k = 0; k < j; k++) {
                if ((long)nums[j] - (long)nums[k] == diff) {
                    dp[i][j] += dp[j][k];
                }
            }
            total += dp[i][j] - 1;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return total;
}