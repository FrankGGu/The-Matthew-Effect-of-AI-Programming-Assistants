#include <stdio.h>
#include <stdlib.h>

int splitArray(int* nums, int numsSize) {
    int count = 0;
    int prefixSum = 0;
    int totalSum = 0;

    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        prefixSum += nums[i];
        if (prefixSum == totalSum - prefixSum) {
            count++;
            prefixSum = 0;
        }
    }

    return count;
}