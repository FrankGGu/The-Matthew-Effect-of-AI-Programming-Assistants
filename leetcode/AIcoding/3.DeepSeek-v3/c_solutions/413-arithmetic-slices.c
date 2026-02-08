int numberOfArithmeticSlices(int* nums, int numsSize) {
    if (numsSize < 3) return 0;

    int count = 0;
    int dp = 0;

    for (int i = 2; i < numsSize; i++) {
        if (nums[i] - nums[i-1] == nums[i-1] - nums[i-2]) {
            dp = dp + 1;
            count += dp;
        } else {
            dp = 0;
        }
    }

    return count;
}