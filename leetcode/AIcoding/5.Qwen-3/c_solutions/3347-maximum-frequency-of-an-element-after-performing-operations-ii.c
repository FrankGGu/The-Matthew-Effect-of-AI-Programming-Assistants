#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxFrequency(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    int left = 0;
    int maxFreq = 0;
    long long total = 0;

    for (int right = 0; right < numsSize; right++) {
        total += nums[right];

        while (total - nums[right] * (right - left + 1) > k) {
            total -= nums[left];
            left++;
        }

        maxFreq = fmax(maxFreq, right - left + 1);
    }

    return maxFreq;
}