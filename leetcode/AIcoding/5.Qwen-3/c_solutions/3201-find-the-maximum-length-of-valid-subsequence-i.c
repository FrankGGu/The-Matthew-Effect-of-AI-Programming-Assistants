#include <stdio.h>
#include <stdlib.h>

int maximumLength(int* nums, int numsSize) {
    int count[1001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int maxLen = 0;
    for (int i = 1; i <= 1000; i++) {
        if (count[i] > 0 && count[i + 1] > 0) {
            maxLen += 2;
        } else if (count[i] > 0) {
            maxLen++;
        }
    }

    return maxLen;
}