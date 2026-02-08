#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int waysToSplitArray(int* nums, int numsSize, int k) {
    long long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    long long currentSum = 0;
    int count = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        currentSum += nums[i];
        if (currentSum >= totalSum - currentSum + k) {
            count++;
        }
    }

    return count;
}