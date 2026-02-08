#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minIncrementToMakeArrayUnique(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= nums[i - 1]) {
            res += nums[i - 1] + 1 - nums[i];
            nums[i] = nums[i - 1] + 1;
        }
    }
    return res;
}