#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxPartitionAfterOperations(int* nums, int numsSize){
    int mask = 0;
    for (int i = 0; i < numsSize; i++) {
        mask |= nums[i];
    }
    int count = 0;
    int currentMask = 0;
    for (int i = 0; i < numsSize; i++) {
        currentMask |= nums[i];
        if (currentMask == mask) {
            count++;
            currentMask = 0;
        }
    }
    if (currentMask != 0) {
        count++;
    }
    return count > 0 ? count : 1;
}