#include <stdio.h>
#include <stdlib.h>

bool hasTrailingZeros(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            count++;
        }
    }
    return count >= 2;
}