#include <stdlib.h> 

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minOperations(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int median = nums[numsSize / 2];

    long long operations = 0;
    for (int i = 0; i < numsSize; i++) {
        operations += abs(nums[i] - median);
    }

    return operations;
}