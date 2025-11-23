#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxFrequencyElements(int* nums, int numsSize) {
    int freq[101] = {0};
    int max_freq = 0;

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
        if (freq[nums[i]] > max_freq) {
            max_freq = freq[nums[i]];
        }
    }

    int count = 0;
    for (int i = 0; i <= 100; i++) {
        if (freq[i] == max_freq) {
            count += freq[i];
        }
    }

    return count;
}