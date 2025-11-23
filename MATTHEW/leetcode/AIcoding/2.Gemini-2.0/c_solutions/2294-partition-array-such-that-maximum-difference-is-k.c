#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int partitionArray(int* nums, int numsSize, int k) {
    if (numsSize == 0) return 0;

    qsort(nums, numsSize, sizeof(int), compare);

    int count = 1;
    int start = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] - start > k) {
            count++;
            start = nums[i];
        }
    }

    return count;
}

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}