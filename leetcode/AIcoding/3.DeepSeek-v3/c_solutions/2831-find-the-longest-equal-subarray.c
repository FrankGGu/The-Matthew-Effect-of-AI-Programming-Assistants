#include <stdlib.h>

int longestEqualSubarray(int* nums, int numsSize, int k) {
    int *count = (int*)calloc(numsSize + 1, sizeof(int));
    int left = 0, max_freq = 0;

    for (int right = 0; right < numsSize; right++) {
        count[nums[right]]++;
        max_freq = (count[nums[right]] > max_freq) ? count[nums[right]] : max_freq;

        if (right - left + 1 - max_freq > k) {
            count[nums[left]]--;
            left++;
        }
    }

    free(count);
    return max_freq;
}