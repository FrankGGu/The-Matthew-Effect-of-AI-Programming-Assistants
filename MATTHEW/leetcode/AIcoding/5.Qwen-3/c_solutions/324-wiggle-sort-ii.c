#include <stdio.h>
#include <stdlib.h>

void wiggleSort(int* nums, int numsSize) {
    int* copy = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        copy[i] = nums[i];
    }
    qsort(copy, numsSize, sizeof(int), (int(*)(const void*, const void*))strcmp);
    int i = 1, j = numsSize - 1;
    while (i < numsSize) {
        nums[i] = copy[j];
        i += 2;
        j--;
    }
    i = 0;
    j = numsSize - 1;
    while (i < numsSize) {
        nums[i] = copy[j];
        i += 2;
        j--;
    }
    free(copy);
}