#include <stdio.h>
#include <stdlib.h>

int** subsets(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = 1 << numsSize;
    int** result = (int**)malloc(*returnSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(*returnSize * sizeof(int));

    for (int i = 0; i < *returnSize; i++) {
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if (i & (1 << j)) {
                count++;
            }
        }
        (*returnColumnSizes)[i] = count;
        result[i] = (int*)malloc(count * sizeof(int));
        int index = 0;
        for (int j = 0; j < numsSize; j++) {
            if (i & (1 << j)) {
                result[i][index++] = nums[j];
            }
        }
    }

    return result;
}