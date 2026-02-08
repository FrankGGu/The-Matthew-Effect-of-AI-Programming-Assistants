#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int minOperations(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int uniqueCount = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[i - 1]) {
            nums[uniqueCount++] = nums[i];
        }
    }

    int maxCount = 0;
    int j = 0;
    for (int i = 0; i < uniqueCount; i++) {
        while (j < uniqueCount && nums[j] <= nums[i] + numsSize - 1) {
            j++;
        }
        if (j - i > maxCount) {
            maxCount = j - i;
        }
    }

    return numsSize - maxCount;
}