#include <stdio.h>
#include <stdlib.h>

int maxSubarrays(int* nums, int numsSize) {
    int result = 0;
    int currentSum = 0;
    for (int i = 0; i < numsSize; i++) {
        currentSum += nums[i];
        if (currentSum == 0) {
            result++;
            currentSum = 0;
        }
    }
    return result;
}