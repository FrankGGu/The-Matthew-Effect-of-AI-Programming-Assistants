#include <stdio.h>
#include <stdlib.h>

char** summaryRanges(int* nums, int numsSize, int* returnSize) {
    if (nums == NULL || numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    char** result = (char**)malloc(numsSize * sizeof(char*));
    int count = 0;
    int start = 0;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[i - 1] + 1) {
            int len = 0;
            if (start == i - 1) {
                len = snprintf(NULL, 0, "%d", nums[start]);
            } else {
                len = snprintf(NULL, 0, "%d->%d", nums[start], nums[i - 1]);
            }
            result[count] = (char*)malloc((len + 1) * sizeof(char));
            if (start == i - 1) {
                sprintf(result[count], "%d", nums[start]);
            } else {
                sprintf(result[count], "%d->%d", nums[start], nums[i - 1]);
            }
            count++;
            start = i;
        }
    }

    int len = 0;
    if (start == numsSize - 1) {
        len = snprintf(NULL, 0, "%d", nums[start]);
    } else {
        len = snprintf(NULL, 0, "%d->%d", nums[start], nums[numsSize - 1]);
    }
    result[count] = (char*)malloc((len + 1) * sizeof(char));
    if (start == numsSize - 1) {
        sprintf(result[count], "%d", nums[start]);
    } else {
        sprintf(result[count], "%d->%d", nums[start], nums[numsSize - 1]);
    }
    count++;

    *returnSize = count;
    return result;
}