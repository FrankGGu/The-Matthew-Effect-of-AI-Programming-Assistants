#include <stdio.h>
#include <stdlib.h>

int minimumDifference(int* nums1, int nums1Size, int* nums2, int nums2Size, int target) {
    int half = nums1Size / 2;
    int total = 1 << half;
    int* sums1 = (int*)malloc(total * sizeof(int));
    for (int i = 0; i < total; i++) {
        int sum = 0;
        for (int j = 0; j < half; j++) {
            if (i & (1 << j)) {
                sum += nums1[j];
            }
        }
        sums1[i] = sum;
    }

    half = nums2Size / 2;
    total = 1 << half;
    int* sums2 = (int*)malloc(total * sizeof(int));
    for (int i = 0; i < total; i++) {
        int sum = 0;
        for (int j = 0; j < half; j++) {
            if (i & (1 << j)) {
                sum += nums2[j];
            }
        }
        sums2[i] = sum;
    }

    qsort(sums2, 1 << (nums2Size / 2), sizeof(int), cmpfunc);
    int minDiff = abs(target);
    for (int i = 0; i < (1 << (nums1Size / 2)); i++) {
        int complement = target - sums1[i];
        int* pos = (int*)bsearch(&complement, sums2, 1 << (nums2Size / 2), sizeof(int), cmpfunc);
        if (pos) {
            minDiff = 0;
            break;
        }
        int idx = ~pos - sums2;
        if (idx >= 0) {
            minDiff = fmin(minDiff, abs(target - (sums1[i] + sums2[idx])));
        }
        if (idx < (1 << (nums2Size / 2)) - 1) {
            minDiff = fmin(minDiff, abs(target - (sums1[i] + sums2[idx + 1])));
        }
    }

    free(sums1);
    free(sums2);
    return minDiff;
}

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}