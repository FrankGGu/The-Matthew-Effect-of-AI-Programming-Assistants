#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** summaryRanges(int* nums, int numsSize, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    char** result = (char**)malloc(sizeof(char*) * numsSize);
    int count = 0;

    for (int i = 0; i < numsSize; ) {
        int start = nums[i];
        while (i + 1 < numsSize && nums[i + 1] == nums[i] + 1) {
            i++;
        }
        if (start == nums[i]) {
            result[count] = (char*)malloc(20 * sizeof(char));
            sprintf(result[count], "%d", start);
        } else {
            result[count] = (char*)malloc(20 * sizeof(char));
            sprintf(result[count], "%d->%d", start, nums[i]);
        }
        count++;
        i++;
    }

    *returnSize = count;
    return result;
}