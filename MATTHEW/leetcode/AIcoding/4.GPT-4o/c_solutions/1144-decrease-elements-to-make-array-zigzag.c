int movesToMakeZigzag(int* nums, int numsSize) {
    int res1 = 0, res2 = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            if (i > 0 && nums[i] >= nums[i - 1]) {
                res1 += nums[i] - nums[i - 1] + 1;
            }
            if (i < numsSize - 1 && nums[i] >= nums[i + 1]) {
                res1 += nums[i] - nums[i + 1] + 1;
            }
        } else {
            if (i > 0 && nums[i] <= nums[i - 1]) {
                res2 += nums[i - 1] - nums[i] + 1;
            }
            if (i < numsSize - 1 && nums[i] <= nums[i + 1]) {
                res2 += nums[i + 1] - nums[i] + 1;
            }
        }
    }

    return res1 < res2 ? res1 : res2;
}