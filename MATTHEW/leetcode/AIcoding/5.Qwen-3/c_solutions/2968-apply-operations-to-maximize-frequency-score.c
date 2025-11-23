#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxFrequencyScore(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    int left = 0;
    int maxFreq = 0;
    long long sum = 0;

    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];

        while ((long long)(right - left + 1) * nums[right] - sum > k) {
            sum -= nums[left];
            left++;
        }

        maxFreq = fmax(maxFreq, right - left + 1);
    }

    return maxFreq;
}