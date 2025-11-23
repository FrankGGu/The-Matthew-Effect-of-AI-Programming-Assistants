#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findMinGroups(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int minGroup = 0;
    int count = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i - 1]) {
            count++;
        } else {
            minGroup += (count + 1) / 2;
            count = 1;
        }
    }
    minGroup += (count + 1) / 2;
    return minGroup;
}