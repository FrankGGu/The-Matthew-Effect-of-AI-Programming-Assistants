int minMaxGame(int* nums, int numsSize) {
    while (numsSize > 1) {
        for (int i = 0; i < numsSize / 2; i++) {
            if (i % 2 == 0) {
                nums[i] = fmin(nums[2 * i], nums[2 * i + 1]);
            } else {
                nums[i] = fmax(nums[2 * i], nums[2 * i + 1]);
            }
        }
        numsSize /= 2;
    }
    return nums[0];
}