#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize){
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            if (i + 1 < numsSize && nums[i + 1] == 0) {
                return -1;
            }
            count++;
        }
    }
    return count;
}