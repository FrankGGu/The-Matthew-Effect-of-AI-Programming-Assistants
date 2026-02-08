#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCompleteSubarrays(int* nums, int numsSize) {
    int count = 0;
    int distinctCount = 0;
    int freq[2001] = {0};
    for (int i = 0; i < numsSize; i++) {
        if (freq[nums[i]] == 0) {
            distinctCount++;
        }
        freq[nums[i]]++;
    }

    for (int i = 0; i < numsSize; i++) {
        int currDistinct = 0;
        int currFreq[2001] = {0};
        for (int j = i; j < numsSize; j++) {
            if (currFreq[nums[j]] == 0) {
                currDistinct++;
            }
            currFreq[nums[j]]++;
            if (currDistinct == distinctCount) {
                count++;
            }
        }
    }

    return count;
}