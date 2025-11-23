#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getAverages(int* nums, int numsSize, int k, int* returnSize){
    *returnSize = numsSize;
    int* averages = (int*)malloc(numsSize * sizeof(int));
    if (k > numsSize / 2) {
        for (int i = 0; i < numsSize; i++) {
            averages[i] = -1;
        }
        return averages;
    }

    long long windowSum = 0;
    for (int i = 0; i < numsSize; i++) {
        averages[i] = -1;
    }

    for (int i = 0; i < 2 * k + 1 && i < numsSize; i++) {
        windowSum += nums[i];
    }

    for (int i = k; i < numsSize - k; i++) {
        averages[i] = (int)(windowSum / (2 * k + 1));
        if (i + k + 1 < numsSize) {
            windowSum += nums[i + k + 1];
        }
        if (i - k >= 0) {
            windowSum -= nums[i - k];
        }
    }

    return averages;
}