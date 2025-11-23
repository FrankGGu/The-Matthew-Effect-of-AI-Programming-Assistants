#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define MAX_FREQ 100001

int minimumOperations(int* nums, int numsSize) {
    if (numsSize == 1) return 0;

    int freq[2][MAX_FREQ] = {0};
    int maxFreq[2] = {0}, secondMaxFreq[2] = {0};
    int maxVal[2] = {-1}, secondMaxVal[2] = {-1};

    for (int i = 0; i < numsSize; i++) {
        int val = nums[i];
        int idx = i % 2;
        freq[idx][val]++;
        if (freq[idx][val] > maxFreq[idx]) {
            secondMaxFreq[idx] = maxFreq[idx];
            secondMaxVal[idx] = maxVal[idx];
            maxFreq[idx] = freq[idx][val];
            maxVal[idx] = val;
        } else if (freq[idx][val] > secondMaxFreq[idx]) {
            secondMaxFreq[idx] = freq[idx][val];
            secondMaxVal[idx] = val;
        }
    }

    if (maxVal[0] != maxVal[1]) {
        return numsSize - maxFreq[0] - maxFreq[1];
    } else {
        return numsSize - (maxFreq[0] + secondMaxFreq[1]);
    }
}