#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxGoodSubarraySum(int* nums, int numsSize) {
    int maxSum = 0;
    int currentSum = 0;
    int count[26] = {0};
    int uniqueCount = 0;

    for (int left = 0, right = 0; right < numsSize; right++) {
        int index = nums[right] - 'a';
        if (count[index] == 0) {
            uniqueCount++;
        }
        count[index]++;

        while (uniqueCount > 1) {
            int leftIndex = nums[left] - 'a';
            count[leftIndex]--;
            if (count[leftIndex] == 0) {
                uniqueCount--;
            }
            left++;
        }

        currentSum = 0;
        for (int i = 0; i < 26; i++) {
            if (count[i] > 0) {
                currentSum += (i + 'a');
            }
        }

        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    return maxSum;
}