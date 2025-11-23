#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** getAverages(int* nums, int numsSize, int k, int* returnSize, int** returnColumnSizes) {
    int n = numsSize;
    int** result = (int**)malloc(sizeof(int*) * (n - 2 * k));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (n - 2 * k));
    *returnSize = n - 2 * k;

    if (n < 2 * k) {
        *returnSize = 0;
        return NULL;
    }

    long long sum = 0;
    for (int i = 0; i < 2 * k; i++) {
        sum += nums[i];
    }

    for (int i = 0; i < n - 2 * k; i++) {
        result[i] = (int*)malloc(sizeof(int) * 1);
        result[i][0] = sum / (2 * k + 1);
        if (i + 2 * k + 1 < n) {
            sum -= nums[i];
            sum += nums[i + 2 * k + 1];
        }
        (*returnColumnSizes)[i] = 1;
    }

    return result;
}