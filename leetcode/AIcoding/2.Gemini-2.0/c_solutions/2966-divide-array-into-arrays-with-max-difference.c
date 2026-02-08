#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int** divideArray(int* nums, int numsSize, int k, int* returnSize, int** returnColumnSizes) {
    qsort(nums, numsSize, sizeof(int), compare);

    *returnSize = 0;
    *returnColumnSizes = NULL;

    if (numsSize % 3 != 0) {
        return NULL;
    }

    int num_arrays = numsSize / 3;
    int** result = (int**)malloc(num_arrays * sizeof(int*));
    *returnColumnSizes = (int*)malloc(num_arrays * sizeof(int));

    for (int i = 0; i < num_arrays; i++) {
        result[i] = (int*)malloc(3 * sizeof(int));
        (*returnColumnSizes)[i] = 3;

        if (nums[i * 3 + 2] - nums[i * 3] > k) {
            for(int j = 0; j < i; j++){
                free(result[j]);
            }
            free(result);
            free(*returnColumnSizes);
            *returnSize = 0;
            return NULL;
        }

        result[i][0] = nums[i * 3];
        result[i][1] = nums[i * 3 + 1];
        result[i][2] = nums[i * 3 + 2];
    }

    *returnSize = num_arrays;
    return result;
}