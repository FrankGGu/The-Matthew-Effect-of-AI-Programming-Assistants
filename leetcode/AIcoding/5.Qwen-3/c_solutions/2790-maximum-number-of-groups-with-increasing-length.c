#include <stdio.h>
#include <stdlib.h>

int getMaximumGroups(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), (int (*)(const void*, const void*))strcmp);
    int count = 0;
    int prev = -1;
    int currentLength = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != prev) {
            prev = nums[i];
            currentLength = 1;
        } else {
            currentLength++;
        }
        if (currentLength > count) {
            count++;
        }
    }
    return count;
}