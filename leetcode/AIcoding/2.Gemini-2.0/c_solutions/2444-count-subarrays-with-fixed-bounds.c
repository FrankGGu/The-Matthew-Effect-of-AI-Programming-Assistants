#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubarrays(int* nums, int numsSize, int minK, int maxK) {
    int count = 0;
    int minIndex = -1, maxIndex = -1, leftBound = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < minK || nums[i] > maxK) {
            leftBound = i;
            minIndex = -1;
            maxIndex = -1;
        }
        if (nums[i] == minK) {
            minIndex = i;
        }
        if (nums[i] == maxK) {
            maxIndex = i;
        }
        if (minIndex != -1 && maxIndex != -1) {
            int start = leftBound + 1;
            int end = i;
            count += (int)(fmax(0, fmin(minIndex, maxIndex) - leftBound));
        }
    }
    return count;
}