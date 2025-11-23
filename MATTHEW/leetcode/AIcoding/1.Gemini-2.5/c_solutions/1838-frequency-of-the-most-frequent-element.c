#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxFrequency(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);

    long long currentSum = 0;
    int left = 0;
    int maxFreq = 0;

    for (int right = 0; right < numsSize; right++) {
        currentSum += nums[right];

        while ((long long)(right - left + 1) * nums[right] - currentSum > k) {
            currentSum -= nums[left];
            left++;
        }

        int currentWindowLength = right - left + 1;
        if (currentWindowLength > maxFreq) {
            maxFreq = currentWindowLength;
        }
    }

    return maxFreq;
}