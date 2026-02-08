#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumOfSquares(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (numsSize % (i + 1) == 0) {
            sum += nums[i] * nums[i];
        }
    }
    return sum;
}