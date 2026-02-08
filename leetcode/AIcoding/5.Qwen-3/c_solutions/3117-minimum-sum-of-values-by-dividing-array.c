#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumSum(int* nums, int numsSize, int k) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }
    qsort(sorted, numsSize, sizeof(int), cmpfunc);

    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += sorted[i] * (i + 1);
    }

    free(sorted);
    return sum;
}