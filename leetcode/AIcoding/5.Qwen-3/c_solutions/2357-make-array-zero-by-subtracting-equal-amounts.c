#include <stdio.h>
#include <stdlib.h>

int minimumSubarrays(int* nums, int numsSize) {
    int count = 0;
    int current = 0;
    for (int i = 0; i < numsSize; i++) {
        current += nums[i];
        if (current > 0) {
            count++;
            current = 0;
        }
    }
    return count;
}