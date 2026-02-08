#include <stdio.h>
#include <stdlib.h>

long long maximumTripletValue(int* nums, int numsSize) {
    long long maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] > nums[j]) {
                for (int k = j + 1; k < numsSize; k++) {
                    if (nums[j] > nums[k]) {
                        long long current = (long long)nums[i] - nums[j] - nums[k];
                        if (current > maxVal) {
                            maxVal = current;
                        }
                    }
                }
            }
        }
    }
    return maxVal;
}