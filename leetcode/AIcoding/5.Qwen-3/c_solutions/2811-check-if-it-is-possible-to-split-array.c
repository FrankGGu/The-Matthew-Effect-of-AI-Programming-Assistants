#include <stdio.h>
#include <stdlib.h>

bool checkIfPossible(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    int prefixSum = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        prefixSum += nums[i];
        if (prefixSum == sum - prefixSum) {
            return true;
        }
    }
    return false;
}