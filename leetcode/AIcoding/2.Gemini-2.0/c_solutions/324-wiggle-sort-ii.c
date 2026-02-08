#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void wiggleSort(int* nums, int numsSize) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }

    qsort(sorted, numsSize, sizeof(int), [](const void* a, const void* b) {
        return (*(int*)a - *(int*)b);
    });

    int mid = (numsSize + 1) / 2;
    int i = mid - 1;
    int j = numsSize - 1;

    for (int k = 0; k < numsSize; k++) {
        if (k % 2 == 0) {
            nums[k] = sorted[i];
            i--;
        } else {
            nums[k] = sorted[j];
            j--;
        }
    }

    free(sorted);
}