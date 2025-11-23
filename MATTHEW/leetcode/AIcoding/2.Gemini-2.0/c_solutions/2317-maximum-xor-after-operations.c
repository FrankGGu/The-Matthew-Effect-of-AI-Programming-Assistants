#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumXOR(int* nums, int numsSize) {
    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        result |= nums[i];
    }
    return result;
}