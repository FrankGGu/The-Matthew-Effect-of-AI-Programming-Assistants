#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize) {
    int operations = 0;
    int flip = 0;
    for (int i = 0; i < numsSize; i++) {
        if ((nums[i] ^ flip) == 0) {
            flip ^= 1;
            operations++;
        }
    }
    return operations;
}