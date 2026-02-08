#include <stdio.h>
#include <stdlib.h>

int maxFrequencyElements(int* nums, int numsSize) {
    int freq[201] = {0};
    int maxFreq = 0;
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
        if (freq[nums[i]] > maxFreq) {
            maxFreq = freq[nums[i]];
        }
    }

    int count = 0;
    for (int i = 0; i < 201; i++) {
        if (freq[i] == maxFreq) {
            count += maxFreq;
        }
    }

    return count;
}