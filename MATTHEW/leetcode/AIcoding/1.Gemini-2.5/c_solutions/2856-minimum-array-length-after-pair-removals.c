#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minLengthAfterRemovals(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compareIntegers);

    int count = 0;
    int i = 0;
    int j = numsSize / 2;

    while (i < numsSize / 2 && j < numsSize) {
        if (nums[i] < nums[j]) {
            count++;
            i++;
            j++;
        } else {
            j++;
        }
    }

    return numsSize - (2 * count);
}