#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** subsets(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int n = numsSize;
    int subsetCount = 1 << n; // 2^n subsets
    *returnSize = subsetCount;

    int** result = (int**)malloc(subsetCount * sizeof(int*));
    *returnColumnSizes = (int*)malloc(subsetCount * sizeof(int));

    for (int i = 0; i < subsetCount; i++) {
        int count = 0;
        for (int j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                count++;
            }
        }
        (*returnColumnSizes)[i] = count;
        result[i] = (int*)malloc(count * sizeof(int));
        int index = 0;
        for (int j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                result[i][index++] = nums[j];
            }
        }
    }

    return result;
}