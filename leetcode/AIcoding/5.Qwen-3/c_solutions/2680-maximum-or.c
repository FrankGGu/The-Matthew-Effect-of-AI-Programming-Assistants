#include <stdio.h>
#include <stdlib.h>

int maximumOr(int* nums, int numsSize) {
    int maxOr = 0;
    for (int i = 0; i < numsSize; i++) {
        int current = 0;
        for (int j = 0; j < numsSize; j++) {
            if (i != j) {
                current |= nums[j];
            }
        }
        maxOr = (current > maxOr) ? current : maxOr;
    }
    return maxOr;
}