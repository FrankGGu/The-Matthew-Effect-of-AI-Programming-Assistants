int repeatedNTimes(int* nums, int numsSize) {
    for (int k = 1; k <= 3; k++) {
        for (int i = 0; i < numsSize - k; i++) {
            if (nums[i] == nums[i + k]) {
                return nums[i];
            }
        }
    }
    return -1;
}