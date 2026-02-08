#include <stdio.h>
#include <stdlib.h>

int maximumXOR(int* nums, int numsSize) {
    int max_xor = 0;
    for (int i = 0; i < numsSize; ++i) {
        max_xor ^= nums[i];
    }
    return max_xor;
}