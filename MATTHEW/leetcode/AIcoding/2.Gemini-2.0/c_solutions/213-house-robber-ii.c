#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rob_linear(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];

    int dp[numsSize];
    dp[0] = nums[0];
    dp[1] = (nums[0] > nums[1]) ? nums[0] : nums[1];

    for (int i = 2; i < numsSize; i++) {
        dp[i] = (dp[i - 2] + nums[i] > dp[i - 1]) ? (dp[i - 2] + nums[i]) : dp[i - 1];
    }

    return dp[numsSize - 1];
}

int rob(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];

    int* nums1 = (int*)malloc(sizeof(int) * (numsSize - 1));
    int* nums2 = (int*)malloc(sizeof(int) * (numsSize - 1));

    for (int i = 0; i < numsSize - 1; i++) {
        nums1[i] = nums[i];
        nums2[i] = nums[i + 1];
    }

    int res1 = rob_linear(nums1, numsSize - 1);
    int res2 = rob_linear(nums2, numsSize - 1);

    free(nums1);
    free(nums2);

    return (res1 > res2) ? res1 : res2;
}