int minOperations(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    int operations = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= nums[i-1]) {
            int increment = nums[i-1] - nums[i] + 1;
            operations += increment;
            nums[i] += increment;
        }
    }
    return operations;
}