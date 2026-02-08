int minMaxGame(int* nums, int numsSize) {
    while (numsSize > 1) {
        int newSize = numsSize / 2;
        for (int i = 0; i < newSize; i++) {
            if (i % 2 == 0) {
                nums[i] = (nums[2 * i] < nums[2 * i + 1]) ? nums[2 * i] : nums[2 * i + 1];
            } else {
                nums[i] = (nums[2 * i] > nums[2 * i + 1]) ? nums[2 * i] : nums[2 * i + 1];
            }
        }
        numsSize = newSize;
    }
    return nums[0];
}