#include <stdio.h>
#include <stdlib.h>

int* intersection(int** nums, int numsSize, int* returnSize) {
    int* count = (int*)calloc(1001, sizeof(int));
    int* result = (int*)malloc(1001 * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < nums[i][0]; j++) {
            count[nums[i][j + 1]]++;
        }
    }

    for (int i = 0; i < 1001; i++) {
        if (count[i] == numsSize) {
            result[(*returnSize)++] = i;
        }
    }

    free(count);
    return result;
}