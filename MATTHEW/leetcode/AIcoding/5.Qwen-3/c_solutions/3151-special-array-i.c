#include <stdio.h>
#include <stdlib.h>

int specialArray(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i <= numsSize; i++) {
        count = 0;
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] >= i) {
                count++;
            }
        }
        if (count == i) {
            return i;
        }
    }
    return -1;
}