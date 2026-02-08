#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int specialArray(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] >= i + 1 && (i == numsSize - 1 || nums[i + 1] < i + 1)) {
            return i + 1;
        }
    }
    return 0;
}