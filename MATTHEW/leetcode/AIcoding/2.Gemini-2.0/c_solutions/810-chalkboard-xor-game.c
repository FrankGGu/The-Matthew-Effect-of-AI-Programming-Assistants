#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool xorGame(int* nums, int numsSize){
    int xorSum = 0;
    for (int i = 0; i < numsSize; i++) {
        xorSum ^= nums[i];
    }

    if (numsSize % 2 == 0) {
        return true;
    } else {
        return (xorSum == 0);
    }
}