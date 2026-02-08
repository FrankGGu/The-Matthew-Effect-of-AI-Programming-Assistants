#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int minOperations(int* nums, int numsSize) {
    int ones = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            ones++;
        }
    }
    if (ones > 0) {
        return numsSize - ones;
    }
    int minOps = numsSize + 1;
    for (int i = 0; i < numsSize; i++) {
        int g = nums[i];
        for (int j = i + 1; j < numsSize; j++) {
            g = gcd(g, nums[j]);
            if (g == 1) {
                minOps = (minOps < (j - i + numsSize - 1)) ? minOps : (j - i + numsSize - 1);
                break;
            }
        }
    }
    if (minOps > numsSize) {
        return -1;
    }
    return minOps;
}