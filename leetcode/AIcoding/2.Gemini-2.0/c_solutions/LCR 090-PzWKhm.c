#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rob_helper(int* nums, int start, int end) {
    if (start > end) {
        return 0;
    }
    if (start == end) {
        return nums[start];
    }

    int *dp = (int*)malloc((end - start + 1) * sizeof(int));
    dp[0] = nums[start];
    dp[1] = (nums[start] > nums[start + 1]) ? nums[start] : nums[start + 1];

    for (int i = 2; i <= (end - start); i++) {
        dp[i] = (dp[i - 1] > (dp[i - 2] + nums[start + i])) ? dp[i - 1] : (dp[i - 2] + nums[start + i]);
    }

    int result = dp[end - start];
    free(dp);
    return result;
}

int rob(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return nums[0];
    }
    if (numsSize == 2) {
        return (nums[0] > nums[1]) ? nums[0] : nums[1];
    }

    int case1 = rob_helper(nums, 0, numsSize - 2);
    int case2 = rob_helper(nums, 1, numsSize - 1);

    return (case1 > case2) ? case1 : case2;
}