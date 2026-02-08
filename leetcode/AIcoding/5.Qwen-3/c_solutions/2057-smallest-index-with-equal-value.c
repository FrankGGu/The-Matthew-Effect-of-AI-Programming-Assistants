#include <stdio.h>
#include <stdlib.h>

int smallestEqual(int* nums, int numsSize) {
    int minIndex = -1;
    for (int i = 0; i < numsSize; i++) {
        if (i % 10 == nums[i]) {
            if (minIndex == -1 || i < minIndex) {
                minIndex = i;
            }
        }
    }
    return minIndex;
}