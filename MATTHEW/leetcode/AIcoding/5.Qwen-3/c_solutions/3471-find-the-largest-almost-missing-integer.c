#include <stdio.h>
#include <stdlib.h>

int findLargestAlmostMissingInteger(int* nums, int numsSize) {
    int max = -1;
    int count[1001] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] >= 0 && nums[i] <= 1000) {
            count[nums[i]]++;
        }
    }

    for (int i = 1000; i >= 0; i--) {
        if (count[i] == 1) {
            return i;
        }
    }

    return -1;
}