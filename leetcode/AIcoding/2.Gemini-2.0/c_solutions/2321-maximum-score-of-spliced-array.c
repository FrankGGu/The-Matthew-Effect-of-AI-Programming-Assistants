#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maximumsSplicedArray(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long sum1 = 0, sum2 = 0;
    for (int i = 0; i < nums1Size; i++) {
        sum1 += nums1[i];
        sum2 += nums2[i];
    }

    int maxSum1 = 0, currentSum1 = 0;
    for (int i = 0; i < nums1Size; i++) {
        currentSum1 = max(nums2[i] - nums1[i], currentSum1 + (nums2[i] - nums1[i]));
        maxSum1 = max(maxSum1, currentSum1);
    }

    int maxSum2 = 0, currentSum2 = 0;
    for (int i = 0; i < nums1Size; i++) {
        currentSum2 = max(nums1[i] - nums2[i], currentSum2 + (nums1[i] - nums2[i]));
        maxSum2 = max(maxSum2, currentSum2);
    }

    return max(sum1 + maxSum1, sum2 + maxSum2);
}