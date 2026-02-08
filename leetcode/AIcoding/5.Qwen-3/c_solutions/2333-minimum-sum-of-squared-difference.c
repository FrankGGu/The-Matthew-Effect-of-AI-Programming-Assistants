#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minSumSquareDiff(int* nums1, int nums1Size, int* nums2, int nums2Size, int k1, int k2) {
    int i, j;
    int n = nums1Size;
    int* diff = (int*)malloc(n * sizeof(int));
    for (i = 0; i < n; i++) {
        diff[i] = abs(nums1[i] - nums2[i]);
    }
    qsort(diff, n, sizeof(int), compare);

    for (i = 0; i < n && k1 > 0; i++) {
        int maxDecrement = diff[i];
        int decrement = (k1 >= maxDecrement) ? maxDecrement : k1;
        diff[i] -= decrement;
        k1 -= decrement;
    }

    for (i = 0; i < n && k2 > 0; i++) {
        int maxDecrement = diff[i];
        int decrement = (k2 >= maxDecrement) ? maxDecrement : k2;
        diff[i] -= decrement;
        k2 -= decrement;
    }

    int sum = 0;
    for (i = 0; i < n; i++) {
        sum += diff[i] * diff[i];
    }

    free(diff);
    return sum;
}