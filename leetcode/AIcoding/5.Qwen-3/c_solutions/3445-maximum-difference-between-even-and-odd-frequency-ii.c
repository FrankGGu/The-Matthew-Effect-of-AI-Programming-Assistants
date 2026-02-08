#include <stdio.h>
#include <stdlib.h>

int largestEvenOddDifference(int* nums, int numsSize) {
    int evenFreq[1001] = {0};
    int oddFreq[1001] = {0};
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            evenFreq[nums[i]]++;
        } else {
            oddFreq[nums[i]]++;
        }
    }
    int maxDiff = -1;
    for (int i = 0; i <= 1000; i++) {
        if (evenFreq[i] > 0 && oddFreq[i] > 0) {
            int diff = abs(evenFreq[i] - oddFreq[i]);
            if (diff > maxDiff) {
                maxDiff = diff;
            }
        }
    }
    return maxDiff;
}