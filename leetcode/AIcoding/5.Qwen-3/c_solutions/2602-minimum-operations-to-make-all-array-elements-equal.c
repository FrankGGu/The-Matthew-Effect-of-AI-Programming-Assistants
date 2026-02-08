#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize) {
    int* count = (int*)calloc(numsSize, sizeof(int));
    int maxCount = 0;
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
        if (count[nums[i]] > maxCount) {
            maxCount = count[nums[i]];
        }
    }
    int operations = 0;
    for (int i = 0; i < numsSize; i++) {
        operations += (maxCount - count[nums[i]]);
    }
    free(count);
    return operations;
}