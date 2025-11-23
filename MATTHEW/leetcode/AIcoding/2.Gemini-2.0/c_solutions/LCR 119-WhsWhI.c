#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestConsecutive(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int* sortedNums = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sortedNums[i] = nums[i];
    }

    qsort(sortedNums, numsSize, sizeof(int), [](const void* a, const void* b) {
        return (*(int*)a - *(int*)b);
    });

    int maxLength = 1;
    int currentLength = 1;

    for (int i = 1; i < numsSize; i++) {
        if (sortedNums[i] == sortedNums[i - 1]) {
            continue;
        } else if (sortedNums[i] == sortedNums[i - 1] + 1) {
            currentLength++;
        } else {
            maxLength = (maxLength > currentLength) ? maxLength : currentLength;
            currentLength = 1;
        }
    }

    maxLength = (maxLength > currentLength) ? maxLength : currentLength;

    free(sortedNums);
    return maxLength;
}