void moveZeroes(int* nums, int numsSize) {
    int lastNonZeroIndex = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != 0) {
            nums[lastNonZeroIndex++] = nums[i];
        }
    }
    for (int i = lastNonZeroIndex; i < numsSize; i++) {
        nums[i] = 0;
    }
}