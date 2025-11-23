#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_ACCOUNTS 100001

char **summaryRanges(int* nums, int numsSize, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    char **result = (char **)malloc(numsSize * sizeof(char *));
    *returnSize = 0;

    int start = nums[0];
    for (int i = 0; i < numsSize; i++) {
        if (i + 1 < numsSize && nums[i + 1] == nums[i] + 1) {
            continue;
        } else {
            if (start == nums[i]) {
                result[*returnSize] = (char *)malloc(20 * sizeof(char));
                sprintf(result[*returnSize], "%d", start);
            } else {
                result[*returnSize] = (char *)malloc(30 * sizeof(char));
                sprintf(result[*returnSize], "%d->%d", start, nums[i]);
            }
            (*returnSize)++;
            if (i + 1 < numsSize) {
                start = nums[i + 1];
            }
        }
    }

    return result;
}