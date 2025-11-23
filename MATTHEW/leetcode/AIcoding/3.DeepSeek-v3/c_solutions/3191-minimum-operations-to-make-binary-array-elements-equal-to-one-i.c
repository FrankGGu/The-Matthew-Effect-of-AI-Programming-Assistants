int minOperations(int* nums, int numsSize) {
    int operations = 0;
    for (int i = 0; i < numsSize - 2; i++) {
        if (nums[i] == 0) {
            operations++;
            nums[i] ^= 1;
            nums[i + 1] ^= 1;
            nums[i + 2] ^= 1;
        }
    }

    if (nums[numsSize - 2] == 0 || nums[numsSize - 1] == 0) {
        return -1;
    }

    return operations;
}