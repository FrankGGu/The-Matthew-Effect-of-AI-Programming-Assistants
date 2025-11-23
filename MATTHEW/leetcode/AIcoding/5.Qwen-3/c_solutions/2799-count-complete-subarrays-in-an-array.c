#include <stdio.h>
#include <stdlib.h>

int countCompleteSubarrays(int* nums, int numsSize) {
    int unique = 0;
    int freq[256] = {0};
    for (int i = 0; i < numsSize; i++) {
        if (freq[nums[i]] == 0) unique++;
        freq[nums[i]]++;
    }

    int left = 0, count = 0;
    int windowFreq[256] = {0};
    for (int right = 0; right < numsSize; right++) {
        windowFreq[nums[right]]++;

        while (windowFreq[nums[right]] > 1) {
            windowFreq[nums[left]]--;
            left++;
        }

        if (windowFreq[nums[right]] == 1) {
            int tempUnique = 0;
            for (int i = 0; i < 256; i++) {
                if (windowFreq[i] > 0) tempUnique++;
            }
            if (tempUnique == unique) {
                count++;
            }
        }
    }

    return count;
}