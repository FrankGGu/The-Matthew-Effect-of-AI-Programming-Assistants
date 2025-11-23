#include <stdio.h>
#include <stdlib.h>

int* sortEvenOdd(int* nums, int numsSize, int* returnSize) {
    int* even = (int*)malloc((numsSize / 2 + numsSize % 2) * sizeof(int));
    int* odd = (int*)malloc((numsSize / 2) * sizeof(int));
    int evenCount = 0, oddCount = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            even[evenCount++] = nums[i];
        } else {
            odd[oddCount++] = nums[i];
        }
    }

    qsort(even, evenCount, sizeof(int), cmp);
    qsort(odd, oddCount, sizeof(int), cmp);

    for (int i = 0, j = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            nums[i] = even[j++];
        } else {
            nums[i] = odd[i / 2];
        }
    }

    free(even);
    free(odd);
    *returnSize = numsSize;
    return nums;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}