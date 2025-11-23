#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMaximumLength(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            count++;
        }
    }
    return count;
}