#include <stdlib.h>
#include <stdio.h>
#include <string.h>

char **summaryRanges(int *nums, int numsSize, int *returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    char **result = (char **)malloc(numsSize * sizeof(char *));
    *returnSize = 0;

    int i = 0;
    while (i < numsSize) {
        int start = nums[i];
        int j = i;
        while (j + 1 < numsSize && nums[j + 1] == nums[j] + 1) {
            j++;
        }
        int end = nums[j];

        char *rangeStr = (char *)malloc(25 * sizeof(char)); // Max length for "INT_MIN->INT_MAX" is around 24 chars + null terminator
        if (start == end) {
            snprintf(rangeStr, 25, "%d", start);
        } else {
            snprintf(rangeStr, 25, "%d->%d", start, end);
        }

        result[*returnSize] = rangeStr;
        (*returnSize)++;

        i = j + 1;
    }

    return result;
}