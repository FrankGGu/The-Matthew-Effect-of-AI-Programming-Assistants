#include <stdio.h>
#include <stdlib.h>

int maxEvenOdd(int* nums, int numsSize) {
    int maxDiff = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            for (int j = 0; j < numsSize; j++) {
                if (nums[j] % 2 == 1 && i < j) {
                    int diff = nums[i] - nums[j];
                    if (diff > maxDiff) {
                        maxDiff = diff;
                    }
                }
            }
        }
    }
    return maxDiff;
}