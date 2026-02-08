#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int arrayPairSum(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int sum = 0;
    for (int i = 0; i < numsSize; i += 2) {
        sum += nums[i];
    }
    return sum;
}