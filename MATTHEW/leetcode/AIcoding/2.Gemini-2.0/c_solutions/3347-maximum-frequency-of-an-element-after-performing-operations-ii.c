#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxFrequency(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    long long left = 0;
    long long currSum = 0;
    int maxFreq = 0;
    for (int right = 0; right < numsSize; right++) {
        currSum += nums[right];
        while ((right - left + 1) * (long long)nums[right] - currSum > k) {
            currSum -= nums[left];
            left++;
        }
        maxFreq = (int)fmax(maxFreq, right - left + 1);
    }
    return maxFreq;
}

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}