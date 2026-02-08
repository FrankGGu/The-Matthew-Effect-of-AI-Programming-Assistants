#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maxSubsequence(int* nums, int numsSize, int k, int* returnSize) {
    int* indices = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        indices[i] = i;
    }

    for (int i = 0; i < k; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[indices[i]] < nums[indices[j]]) {
                int temp = indices[i];
                indices[i] = indices[j];
                indices[j] = temp;
            }
        }
    }

    int* result = (int*)malloc(k * sizeof(int));
    int* resultIndices = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        resultIndices[i] = indices[i];
    }

    for (int i = 0; i < k; i++) {
        for (int j = i + 1; j < k; j++) {
            if (resultIndices[i] > resultIndices[j]) {
                int temp = resultIndices[i];
                resultIndices[i] = resultIndices[j];
                resultIndices[j] = temp;
            }
        }
    }

    for (int i = 0; i < k; i++) {
        result[i] = nums[resultIndices[i]];
    }

    *returnSize = k;
    free(indices);
    free(resultIndices);
    return result;
}