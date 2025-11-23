#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int atMostK(int* nums, int numsSize, int k) {
    int left = 0, right = 0, count = 0, distinct = 0;
    int freq[20001] = {0};

    while (right < numsSize) {
        if (freq[nums[right]] == 0) {
            distinct++;
        }
        freq[nums[right]]++;

        while (distinct > k) {
            freq[nums[left]]--;
            if (freq[nums[left]] == 0) {
                distinct--;
            }
            left++;
        }

        count += (right - left + 1);
        right++;
    }
    return count;
}

int subarraysWithKDistinct(int* nums, int numsSize, int k) {
    return atMostK(nums, numsSize, k) - atMostK(nums, numsSize, k - 1);
}