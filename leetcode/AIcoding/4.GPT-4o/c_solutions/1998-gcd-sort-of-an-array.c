#include <stdio.h>
#include <stdlib.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int canBeSorted(int* nums, int numsSize) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }
    qsort(sorted, numsSize, sizeof(int), cmp);

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (gcd(sorted[i], sorted[j]) > 1) {
                if (sorted[i] > sorted[j]) {
                    free(sorted);
                    return 0;
                }
            }
        }
    }

    free(sorted);
    return 1;
}

bool gcdSort(int* nums, int numsSize) {
    return canBeSorted(nums, numsSize);
}