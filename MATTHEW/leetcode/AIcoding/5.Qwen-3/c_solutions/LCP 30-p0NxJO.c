#include <stdio.h>
#include <stdlib.h>

int magicTower(int* nums, int numsSize) {
    long long total = 0;
    long long current = 1;
    int count = 0;
    int i;

    for (i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    if (total < 0) {
        return -1;
    }

    for (i = 0; i < numsSize; i++) {
        current *= nums[i];
        if (current <= 0) {
            count++;
            current = 1;
        }
    }

    return count;
}