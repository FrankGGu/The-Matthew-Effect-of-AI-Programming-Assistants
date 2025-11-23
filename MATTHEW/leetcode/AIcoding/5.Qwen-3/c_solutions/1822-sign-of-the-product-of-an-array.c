#include <stdio.h>
#include <stdlib.h>

int signFunc(int x) {
    if (x > 0) return 1;
    if (x < 0) return -1;
    return 0;
}

int arraySign(int* nums, int numsSize) {
    int product = 1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) return 0;
        if (nums[i] < 0) product *= -1;
    }
    return product;
}