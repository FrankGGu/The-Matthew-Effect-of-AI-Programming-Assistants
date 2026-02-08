#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int** divideArray(int* nums, int numsSize, int k, int* returnSize, int** returnColumnSizes) {
    qsort(nums, numsSize, sizeof(int), compare);
    int** result = (int**)malloc(sizeof(int*) * (numsSize / k));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (numsSize / k));
    *returnSize = numsSize / k;
    for (int i = 0; i < numsSize; i += k) {
        result[i / k] = (int*)malloc(sizeof(int) * k);
        for (int j = 0; j < k; j++) {
            result[i / k][j] = nums[i + j];
        }
        (*returnColumnSizes)[i / k] = k;
    }
    return result;
}