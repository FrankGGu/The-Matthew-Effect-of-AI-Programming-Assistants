#include <stdio.h>
#include <stdlib.h>

int abs(int x) {
    return x < 0 ? -x : x;
}

long long getDifference(long long a, long long b) {
    return abs(a - b);
}

long long minCostToMakeArraysIdentical(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long totalCost = 0;
    for (int i = 0; i < nums1Size; i++) {
        totalCost += getDifference(nums1[i], nums2[i]);
    }
    return totalCost;
}