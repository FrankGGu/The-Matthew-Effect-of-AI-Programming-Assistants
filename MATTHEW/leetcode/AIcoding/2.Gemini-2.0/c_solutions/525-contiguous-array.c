#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMaxLength(int* nums, int numsSize) {
    int maxLen = 0;
    int sum = 0;
    int* firstOccurrence = (int*)malloc((2 * numsSize + 1) * sizeof(int));
    for (int i = 0; i < 2 * numsSize + 1; i++) {
        firstOccurrence[i] = -2;
    }
    firstOccurrence[numsSize] = -1; 

    for (int i = 0; i < numsSize; i++) {
        sum += (nums[i] == 0 ? -1 : 1);
        if (firstOccurrence[sum + numsSize] == -2) {
            firstOccurrence[sum + numsSize] = i;
        } else {
            int len = i - firstOccurrence[sum + numsSize];
            if (len > maxLen) {
                maxLen = len;
            }
        }
    }

    free(firstOccurrence);
    return maxLen;
}