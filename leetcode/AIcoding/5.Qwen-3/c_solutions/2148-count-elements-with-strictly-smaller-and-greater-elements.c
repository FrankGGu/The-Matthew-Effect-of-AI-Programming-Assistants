#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int countElements(int* nums, int numsSize) {
    if (numsSize < 3) return 0;

    int *sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }

    qsort(sorted, numsSize, sizeof(int), compare);

    int count = 0;
    for (int i = 1; i < numsSize - 1; i++) {
        if (sorted[i] > sorted[0] && sorted[i] < sorted[numsSize - 1]) {
            count++;
        }
    }

    free(sorted);
    return count;
}