#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int maximumSum(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    int sum = 0;
    for (int i = 0; i < k; i++) {
        sum += nums[i];
    }
    return sum;
}