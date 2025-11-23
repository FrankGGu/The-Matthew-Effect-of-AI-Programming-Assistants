int rob(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];

    int robLinear(int* nums, int numsSize) {
        int prev1 = 0, prev2 = 0;
        for (int i = 0; i < numsSize; i++) {
            int temp = prev1;
            prev1 = fmax(prev2 + nums[i], prev1);
            prev2 = temp;
        }
        return prev1;
    }

    return fmax(robLinear(nums, numsSize - 1), robLinear(nums + 1, numsSize - 1));
}