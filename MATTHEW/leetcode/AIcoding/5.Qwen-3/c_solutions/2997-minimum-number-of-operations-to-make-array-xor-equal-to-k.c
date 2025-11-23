#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize, int k) {
    int xor = 0;
    for (int i = 0; i < numsSize; i++) {
        xor ^= nums[i];
    }
    int diff = xor ^ k;
    int count = 0;
    while (diff) {
        count += diff & 1;
        diff >>= 1;
    }
    return count;
}