#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mostFrequentEven(int* nums, int numsSize) {
    int freq[100001] = {0};
    int maxFreq = 0;
    int mostFrequent = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            freq[nums[i]]++;
            if (freq[nums[i]] > maxFreq) {
                maxFreq = freq[nums[i]];
                mostFrequent = nums[i];
            } else if (freq[nums[i]] == maxFreq && nums[i] < mostFrequent) {
                mostFrequent = nums[i];
            }
        }
    }

    return mostFrequent;
}