#include <stdio.h>
#include <stdlib.h>

int partitionDisjoint(int* nums, int numsSize) {
    int maxSoFar = nums[0];
    int result = 0;
    int currentMax = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < maxSoFar) {
            result = i;
            maxSoFar = currentMax;
        } else {
            currentMax = nums[i];
        }
    }

    return result;
}