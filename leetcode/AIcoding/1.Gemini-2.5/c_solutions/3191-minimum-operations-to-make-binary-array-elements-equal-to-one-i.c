int minOperations(int* nums, int numsSize) {
    int operations = 0;
    for (int i = 0; i <= numsSize - 3; i++) {
        if (nums[i] == 0) {
            operations++;
            nums[i] = 1;
            nums[i+1] = 1 - nums[i+1];
            nums[i+2] = 1 - nums[i+2];
        }
    }

    for (int i = numsSize - 2; i < numsSize; i++) {
        if (nums[i] == 0) {
            return -1;
        }
    }

    return operations;
}