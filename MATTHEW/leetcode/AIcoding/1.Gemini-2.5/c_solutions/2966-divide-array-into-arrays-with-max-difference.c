#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int** divideArray(int* nums, int numsSize, int k, int* returnSize, int** returnColumnSizes) {
    qsort(nums, numsSize, sizeof(int), compare);

    *returnSize = numsSize / 3;
    *returnColumnSizes = (int*)malloc(sizeof(int) * (*returnSize));
    int** result = (int**)malloc(sizeof(int*) * (*returnSize));

    for (int i = 0; i < *returnSize; ++i) {
        int idx = i * 3;
        if (nums[idx + 2] - nums[idx] > k) {
            for (int j = 0; j < i; ++j) {
                free(result[j]);
            }
            free(result);
            free(*returnColumnSizes);
            *returnSize = 0;
            *returnColumnSizes = NULL;
            return NULL;
        }

        result[i] = (int*)malloc(sizeof(int) * 3);
        (*returnColumnSizes)[i] = 3;
        result[i][0] = nums[idx];
        result[i][1] = nums[idx + 1];
        result[i][2] = nums[idx + 2];
    }

    return result;
}