#include <stdlib.h>
#include <string.h>

int maxFrequencyElements(int* nums, int numsSize) {
    int freq[101];
    memset(freq, 0, sizeof(freq));

    int maxFreq = 0;
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
        if (freq[nums[i]] > maxFreq) {
            maxFreq = freq[nums[i]];
        }
    }

    int count = 0;
    for (int i = 1; i <= 100; i++) {
        if (freq[i] == maxFreq) {
            count += maxFreq;
        }
    }

    return count;
}