#include <stdio.h>
#include <stdlib.h>

int** find2DArray(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(numsSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;

    int count[101] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    for (int i = 0; i < 101; i++) {
        if (count[i] > 0) {
            result[*returnSize] = (int*)malloc(count[i] * sizeof(int));
            (*returnColumnSizes)[*returnSize] = count[i];
            int index = 0;
            for (int j = 0; j < numsSize; j++) {
                if (nums[j] == i) {
                    result[*returnSize][index++] = nums[j];
                }
            }
            (*returnSize)++;
        }
    }

    return result;
}