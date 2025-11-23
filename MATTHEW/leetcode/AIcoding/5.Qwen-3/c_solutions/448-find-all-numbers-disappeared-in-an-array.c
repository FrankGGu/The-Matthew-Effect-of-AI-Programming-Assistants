#include <stdio.h>
#include <stdlib.h>

int* findDisappearedNumbers(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* seen = (int*)calloc(numsSize + 1, sizeof(int));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        seen[nums[i]] = 1;
    }

    for (int i = 1; i <= numsSize; i++) {
        if (seen[i] == 0) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    free(seen);
    return result;
}