#include <stdbool.h>
#include <stdlib.h> // For malloc, qsort

static int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool findSubarrays(int* nums, int numsSize) {
    int numSums = numsSize - 1;

    int* sums = (int*)malloc(numSums * sizeof(int));

    for (int i = 0; i < numSums; i++) {
        sums[i] = nums[i] + nums[i+1];
    }

    qsort(sums, numSums, sizeof(int), compareIntegers);

    for (int i = 0; i < numSums - 1; i++) {
        if (sums[i] == sums[i+1]) {
            free(sums);
            return true;
        }
    }

    free(sums);
    return false;
}