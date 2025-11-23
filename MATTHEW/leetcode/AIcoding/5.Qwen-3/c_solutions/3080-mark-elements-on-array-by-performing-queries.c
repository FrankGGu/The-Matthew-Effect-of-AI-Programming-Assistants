#include <stdio.h>
#include <stdlib.h>

int* markElements(int* nums, int numsSize, int* queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* count = (int*)calloc(numsSize, sizeof(int));

    for (int i = 0; i < queriesSize; i++) {
        int val = queries[i];
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] == val) {
                count[j]++;
            }
        }
    }

    for (int i = 0; i < numsSize; i++) {
        result[i] = count[i];
    }

    *returnSize = numsSize;
    free(count);
    return result;
}