#include <stdio.h>
#include <stdlib.h>

int maxSequenceValue(int* nums, int numsSize) {
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        int current = nums[i];
        int total = current;
        for (int j = i + 1; j < numsSize; j++) {
            total += nums[j];
            if (total > maxVal) {
                maxVal = total;
            }
        }
    }
    return maxVal;
}