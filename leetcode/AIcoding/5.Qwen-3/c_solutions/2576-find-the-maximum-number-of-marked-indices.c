#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxMarkedIndices(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int i = 0, j = (numsSize + 1) / 2;
    while (i < (numsSize + 1) / 2 && j < numsSize) {
        if (nums[j] >= 2 * nums[i]) {
            i++;
        }
        j++;
    }
    return i;
}