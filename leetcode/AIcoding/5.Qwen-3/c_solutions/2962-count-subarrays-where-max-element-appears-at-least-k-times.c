#include <stdio.h>
#include <stdlib.h>

int countSubarrays(int* nums, int numsSize, int k) {
    int count = 0;
    int maxVal = *nums;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    int left = 0;
    int maxCount = 0;

    for (int right = 0; right < numsSize; right++) {
        if (nums[right] == maxVal) {
            maxCount++;
        }

        while (maxCount >= k) {
            count += numsSize - right;
            if (nums[left] == maxVal) {
                maxCount--;
            }
            left++;
        }
    }

    return count;
}