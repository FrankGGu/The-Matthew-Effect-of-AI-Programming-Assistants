#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* intersection(int** nums, int numsSize, int* numsColSize, int* returnSize) {
    int* freq = (int*)calloc(1001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsColSize[i]; j++) {
            freq[nums[i][j]]++;
        }
    }

    int count = 0;
    for (int i = 1; i <= 1000; i++) {
        if (freq[i] == numsSize) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    *returnSize = count;
    int index = 0;
    for (int i = 1; i <= 1000; i++) {
        if (freq[i] == numsSize) {
            result[index++] = i;
        }
    }

    return result;
}