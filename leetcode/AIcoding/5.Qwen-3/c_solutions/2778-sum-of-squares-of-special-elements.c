#include <stdio.h>
#include <stdlib.h>

int sumOfSquares(int* nums, int numsSize) {
    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            result += nums[i] * nums[i];
        }
    }
    return result;
}