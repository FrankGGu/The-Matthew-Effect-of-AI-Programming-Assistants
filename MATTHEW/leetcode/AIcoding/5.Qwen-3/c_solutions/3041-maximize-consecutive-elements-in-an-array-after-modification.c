#include <stdio.h>
#include <stdlib.h>

int maximumConsecutive(int* nums, int numsSize) {
    int* freq = (int*)calloc(numsSize + 2, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] >= 0 && nums[i] <= numsSize) {
            freq[nums[i]]++;
        }
    }

    int maxCount = 0;
    int currentCount = 0;

    for (int i = 0; i <= numsSize; i++) {
        if (freq[i] > 0) {
            currentCount++;
            if (currentCount > maxCount) {
                maxCount = currentCount;
            }
        } else {
            currentCount = 0;
        }
    }

    free(freq);
    return maxCount;
}