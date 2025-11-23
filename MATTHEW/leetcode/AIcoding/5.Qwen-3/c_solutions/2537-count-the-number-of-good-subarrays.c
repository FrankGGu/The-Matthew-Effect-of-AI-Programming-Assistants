#include <stdio.h>
#include <stdlib.h>

int countGoodSubarrays(int* nums, int numsSize) {
    int count = 0;
    int left = 0;
    int freq[10001] = {0};
    int maxFreq = 0;

    for (int right = 0; right < numsSize; right++) {
        freq[nums[right]]++;
        maxFreq = (freq[nums[right]] > maxFreq) ? freq[nums[right]] : maxFreq;

        while (maxFreq * (right - left + 1) < (right - left + 1)) {
            freq[nums[left]]--;
            left++;
        }

        count += right - left + 1;
    }

    return count;
}