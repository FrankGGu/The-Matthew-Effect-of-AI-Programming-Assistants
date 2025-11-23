#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxFrequency(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), (int (*)(const void *, const void *))cmpfunc);

    long long currentSum = 0;
    int left = 0;
    int maxFreq = 0;

    for (int right = 0; right < numsSize; right++) {
        currentSum += nums[right];

        while ((long long)(right - left + 1) * nums[right] - currentSum > k) {
            currentSum -= nums[left];
            left++;
        }

        if (right - left + 1 > maxFreq) {
            maxFreq = right - left + 1;
        }
    }

    return maxFreq;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}