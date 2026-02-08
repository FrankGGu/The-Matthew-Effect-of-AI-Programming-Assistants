#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** summaryRanges(int* nums, int numsSize, int* returnSize){
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    char **result = (char **)malloc(numsSize * sizeof(char *));
    int resultIndex = 0;

    int start = nums[0];
    int end = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == end + 1) {
            end = nums[i];
        } else {
            char *str;
            if (start == end) {
                asprintf(&str, "%d", start);
            } else {
                asprintf(&str, "%d->%d", start, end);
            }
            result[resultIndex++] = str;
            start = nums[i];
            end = nums[i];
        }
    }

    char *str;
    if (start == end) {
        asprintf(&str, "%d", start);
    } else {
        asprintf(&str, "%d->%d", start, end);
    }
    result[resultIndex++] = str;

    *returnSize = resultIndex;
    return result;
}