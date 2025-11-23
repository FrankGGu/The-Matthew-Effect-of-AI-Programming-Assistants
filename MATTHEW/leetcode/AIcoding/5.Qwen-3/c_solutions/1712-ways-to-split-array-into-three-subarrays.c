#include <stdio.h>
#include <stdlib.h>

int numberOfWays(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    int leftSum = 0;
    int rightSum = 0;
    int count = 0;

    for (int i = 1; i < numsSize - 1; i++) {
        leftSum += nums[i - 1];
        rightSum = total - leftSum - nums[i];

        if (leftSum > nums[i] && rightSum > nums[i]) {
            count++;
        }
    }

    return count;
}