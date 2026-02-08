#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int maxGroupSize(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            count++;
        }
    }
    return numsSize - count + (count > 0);
}