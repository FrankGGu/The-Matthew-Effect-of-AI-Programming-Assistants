#include <stdlib.h>

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** modifyColumns(int** nums, int numsSize, int* numsColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = numsSize;
    *returnColumnSizes = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        (*returnColumnSizes)[i] = *numsColSize;
    }

    int** result = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; i++) {
        result[i] = (int*)malloc((*numsColSize) * sizeof(int));
        for (int j = 0; j < *numsColSize; j++) {
            if (j % 2 == 0) {
                result[i][j] = nums[i][j];
            } else {
                result[i][j] = nums[numsSize - 1 - i][j];
            }
        }
    }

    return result;
}