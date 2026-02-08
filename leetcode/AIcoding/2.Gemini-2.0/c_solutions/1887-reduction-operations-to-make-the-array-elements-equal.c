#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int reductionOperations(int* nums, int numsSize){
    qsort(nums, numsSize, sizeof(int), compare);
    int operations = 0;
    int distinct_count = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[i - 1]) {
            distinct_count++;
        }
        operations += distinct_count;
    }
    return operations;
}