#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minCost(int* nums, int numsSize) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }
    qsort(sorted, numsSize, sizeof(int), compare);

    int* pos = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        pos[sorted[i]] = i;
    }

    int cost = 0;
    for (int i = 0; i < numsSize; i++) {
        cost += abs(pos[nums[i]] - i);
    }

    free(sorted);
    free(pos);
    return cost;
}