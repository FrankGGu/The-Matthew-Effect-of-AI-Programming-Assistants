#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize, int k) {
    int xorSum = 0;
    for (int i = 0; i < numsSize; i++) {
        xorSum ^= nums[i];
    }

    int xorResult = xorSum ^ k;
    int operations = 0;
    while (xorResult > 0) {
        operations += (xorResult & 1);
        xorResult >>= 1;
    }

    return operations;
}