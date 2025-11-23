#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumDifference(int* nums, int numsSize){
    int maxDiff = -1;
    int minVal = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > minVal) {
            int diff = nums[i] - minVal;
            if (diff > maxDiff) {
                maxDiff = diff;
            }
        } else {
            minVal = nums[i];
        }
    }
    return maxDiff;
}