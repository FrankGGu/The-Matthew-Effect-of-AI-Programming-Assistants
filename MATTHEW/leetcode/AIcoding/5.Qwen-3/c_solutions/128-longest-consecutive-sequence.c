#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int longestConsecutive(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    qsort(nums, numsSize, sizeof(int), compare);

    int maxLen = 1;
    int currentLen = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[i-1]) {
            if (nums[i] == nums[i-1] + 1) {
                currentLen++;
                if (currentLen > maxLen) {
                    maxLen = currentLen;
                }
            } else {
                currentLen = 1;
            }
        }
    }

    return maxLen;
}