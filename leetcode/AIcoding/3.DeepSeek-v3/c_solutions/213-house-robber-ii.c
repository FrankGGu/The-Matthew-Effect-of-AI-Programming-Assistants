int rob(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];
    if (numsSize == 2) return (nums[0] > nums[1]) ? nums[0] : nums[1];

    int dp1[numsSize], dp2[numsSize];

    dp1[0] = nums[0];
    dp1[1] = (nums[0] > nums[1]) ? nums[0] : nums[1];

    for (int i = 2; i < numsSize - 1; i++) {
        dp1[i] = (dp1[i-1] > dp1[i-2] + nums[i]) ? dp1[i-1] : dp1[i-2] + nums[i];
    }

    dp2[0] = 0;
    dp2[1] = nums[1];

    for (int i = 2; i < numsSize; i++) {
        dp2[i] = (dp2[i-1] > dp2[i-2] + nums[i]) ? dp2[i-1] : dp2[i-2] + nums[i];
    }

    return (dp1[numsSize-2] > dp2[numsSize-1]) ? dp1[numsSize-2] : dp2[numsSize-1];
}