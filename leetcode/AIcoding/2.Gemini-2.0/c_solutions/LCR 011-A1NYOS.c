#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMaxLength(int* nums, int numsSize) {
    int maxLength = 0;
    int count = 0;
    int* firstIndex = (int*)malloc(sizeof(int) * (2 * numsSize + 1));
    for (int i = 0; i < 2 * numsSize + 1; i++) {
        firstIndex[i] = -2;
    }
    firstIndex[numsSize] = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            count--;
        } else {
            count++;
        }

        if (firstIndex[count + numsSize] == -2) {
            firstIndex[count + numsSize] = i;
        } else {
            int length = i - firstIndex[count + numsSize];
            if (length > maxLength) {
                maxLength = length;
            }
        }
    }

    free(firstIndex);
    return maxLength;
}