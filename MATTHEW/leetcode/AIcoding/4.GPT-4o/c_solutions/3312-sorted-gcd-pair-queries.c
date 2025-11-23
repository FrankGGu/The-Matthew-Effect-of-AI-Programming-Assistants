#include <stdio.h>
#include <stdlib.h>

int gcd(int a, int b) {
    while (b) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}

int* gcdSort(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    int* gcds = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }

    qsort(sorted, numsSize, sizeof(int), (int(*)(const void*, const void*))cmp);

    for (int i = 0; i < numsSize; i++) {
        gcds[i] = gcd(nums[i], sorted[i]);
    }

    for (int i = 0; i < numsSize; i++) {
        result[i] = gcds[i];
    }

    *returnSize = numsSize;
    free(sorted);
    free(gcds);
    return result;
}