#include <stdio.h>
#include <stdlib.h>

int* decompressRLEnabled(int* nums, int numsSize, int* returnSize) {
    int* result = NULL;
    int count = 0;

    for (int i = 0; i < numsSize; i += 2) {
        int freq = nums[i];
        int val = nums[i + 1];
        count += freq;
    }

    result = (int*)malloc(count * sizeof(int));
    if (!result) {
        *returnSize = 0;
        return NULL;
    }

    int index = 0;
    for (int i = 0; i < numsSize; i += 2) {
        int freq = nums[i];
        int val = nums[i + 1];
        for (int j = 0; j < freq; j++) {
            result[index++] = val;
        }
    }

    *returnSize = count;
    return result;
}