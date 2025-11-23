#include <stdio.h>
#include <stdlib.h>

int singleNumber(int* nums, int numsSize) {
    int result = 0;
    for (int i = 0; i < 32; i++) {
        int bitSum = 0;
        for (int j = 0; j < numsSize; j++) {
            bitSum += (nums[j] >> i) & 1;
        }
        if (bitSum % 3 != 0) {
            result |= (bitSum % 3) << i;
        }
    }
    return result;
}