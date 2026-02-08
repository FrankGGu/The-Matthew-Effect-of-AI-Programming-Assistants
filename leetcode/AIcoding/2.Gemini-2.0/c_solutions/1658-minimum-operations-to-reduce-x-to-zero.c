#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize, int x){
    int target = 0;
    for (int i = 0; i < numsSize; i++) {
        target += nums[i];
    }
    target -= x;

    if (target == 0) {
        return numsSize;
    }

    int maxLength = -1;
    int currentSum = 0;
    int left = 0;
    for (int right = 0; right < numsSize; right++) {
        currentSum += nums[right];
        while (currentSum > target && left <= right) {
            currentSum -= nums[left];
            left++;
        }
        if (currentSum == target) {
            maxLength = fmax(maxLength, right - left + 1);
        }
    }

    if (maxLength == -1) {
        return -1;
    }

    return numsSize - maxLength;
}