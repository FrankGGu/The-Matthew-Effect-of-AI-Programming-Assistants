#include <stdio.h>
#include <stdlib.h>

int* getSneakyNumbers(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    int* count = (int*)calloc(101, sizeof(int));
    int index = 0;

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    for (int i = 0; i <= 100; i++) {
        if (count[i] == 2) {
            result[index++] = i;
        }
    }

    *returnSize = 2;
    free(count);
    return result;
}