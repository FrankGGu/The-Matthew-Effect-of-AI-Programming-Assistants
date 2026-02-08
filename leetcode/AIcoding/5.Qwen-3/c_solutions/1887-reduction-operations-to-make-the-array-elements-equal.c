#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int reductionOperations(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int operations = 0;
    for (int i = numsSize - 1; i > 0; i--) {
        if (nums[i] != nums[i - 1]) {
            operations += numsSize - i;
        }
    }
    return operations;
}