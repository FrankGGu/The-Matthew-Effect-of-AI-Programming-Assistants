#include <stdio.h>
#include <stdlib.h>

int countSubarrays(int* nums, int numsSize, int k) {
    int count = 0;
    int left = 0;
    int right = 0;
    int minCount = 0;
    int maxCount = 0;
    int minVal = k;
    int maxVal = k;

    for (right = 0; right < numsSize; right++) {
        if (nums[right] == minVal) minCount++;
        if (nums[right] == maxVal) maxCount++;

        while (minCount > 0 && maxCount > 0) {
            count += numsSize - right;
            if (nums[left] == minVal) minCount--;
            if (nums[left] == maxVal) maxCount--;
            left++;
        }
    }

    return count;
}