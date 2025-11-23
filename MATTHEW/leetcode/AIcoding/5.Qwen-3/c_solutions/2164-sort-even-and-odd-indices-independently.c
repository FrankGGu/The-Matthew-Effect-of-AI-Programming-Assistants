#include <stdio.h>
#include <stdlib.h>

int* sortEvenOdd(int* nums, int numsSize, int* returnSize) {
    int* even = (int*)malloc((numsSize + 1) / 2 * sizeof(int));
    int* odd = (int*)malloc(numsSize / 2 * sizeof(int));
    int e = 0, o = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            even[e++] = nums[i];
        } else {
            odd[o++] = nums[i];
        }
    }

    qsort(even, e, sizeof(int), (int (*)(const void*, const void*))strcmp);
    qsort(odd, o, sizeof(int), (int (*)(const void*, const void*))strcmp);

    int* result = (int*)malloc(numsSize * sizeof(int));
    e = o = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            result[i] = even[e++];
        } else {
            result[i] = odd[o++];
        }
    }

    *returnSize = numsSize;
    free(even);
    free(odd);
    return result;
}