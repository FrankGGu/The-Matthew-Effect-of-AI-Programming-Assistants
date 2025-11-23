#include <stdio.h>
#include <stdlib.h>

int maxSubarraySum(int* nums, int n) {
    int max_current = nums[0];
    int max_global = nums[0];
    for (int i = 1; i < n; i++) {
        max_current = (max_current + nums[i] > nums[i]) ? max_current + nums[i] : nums[i];
        if (max_current > max_global) {
            max_global = max_current;
        }
    }
    return max_global;
}

int maxScore(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int* diff1 = (int*)malloc(nums1Size * sizeof(int));
    int* diff2 = (int*)malloc(nums1Size * sizeof(int));

    for (int i = 0; i < nums1Size; i++) {
        diff1[i] = nums1[i] - nums2[i];
        diff2[i] = nums2[i] - nums1[i];
    }

    int max1 = maxSubarraySum(diff1, nums1Size);
    int max2 = maxSubarraySum(diff2, nums1Size);

    free(diff1);
    free(diff2);

    return (max1 > max2) ? max1 : max2;
}