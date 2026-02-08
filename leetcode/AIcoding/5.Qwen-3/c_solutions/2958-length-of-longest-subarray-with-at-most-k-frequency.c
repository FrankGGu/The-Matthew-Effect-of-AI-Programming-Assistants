#include <stdio.h>
#include <stdlib.h>

int longestSubarray(int* nums, int numsSize, int k) {
    int maxFreq = 0;
    int left = 0;
    int result = 0;
    int* freq = (int*)calloc(10001, sizeof(int));

    for (int right = 0; right < numsSize; right++) {
        freq[nums[right]]++;

        while (freq[nums[right]] > k) {
            freq[nums[left]]--;
            left++;
        }

        result = (result > (right - left + 1)) ? result : (right - left + 1);
    }

    free(freq);
    return result;
}