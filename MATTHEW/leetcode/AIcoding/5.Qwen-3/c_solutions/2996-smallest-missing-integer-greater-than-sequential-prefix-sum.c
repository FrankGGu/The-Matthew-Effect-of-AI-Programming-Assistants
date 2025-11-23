#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int missingInteger(int* nums, int numsSize) {
    int prefix = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i - 1] + 1) {
            prefix = nums[i];
        } else {
            break;
        }
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int result = prefix + 1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == result) {
            result++;
        }
    }

    return result;
}