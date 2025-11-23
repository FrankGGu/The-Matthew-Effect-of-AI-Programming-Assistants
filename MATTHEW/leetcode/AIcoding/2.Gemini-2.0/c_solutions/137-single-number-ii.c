#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int singleNumber(int* nums, int numsSize) {
    int seenOnce = 0, seenTwice = 0;
    for (int i = 0; i < numsSize; i++) {
        seenOnce = ~seenTwice & (seenOnce ^ nums[i]);
        seenTwice = ~seenOnce & (seenTwice ^ nums[i]);
    }
    return seenOnce;
}