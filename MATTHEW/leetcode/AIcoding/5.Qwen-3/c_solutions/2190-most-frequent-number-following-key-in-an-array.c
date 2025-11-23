#include <stdio.h>
#include <stdlib.h>

int mostFrequent(int* nums, int numsSize, int key) {
    int count = 0;
    int maxCount = 0;
    int result = nums[0];

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == key && i + 1 < numsSize) {
            int currentNum = nums[i + 1];
            int currentCount = 1;

            for (int j = i + 2; j < numsSize; j++) {
                if (nums[j] == currentNum) {
                    currentCount++;
                }
            }

            if (currentCount > maxCount) {
                maxCount = currentCount;
                result = currentNum;
            } else if (currentCount == maxCount && currentNum < result) {
                result = currentNum;
            }
        }
    }

    return result;
}