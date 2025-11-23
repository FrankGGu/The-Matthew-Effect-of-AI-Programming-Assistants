int minOperations(int *nums, int numsSize, int target) {
    int operations = 0;
    for (int i = 0; i < numsSize; i++) {
        operations += abs(nums[i] - target);
    }
    return operations;
}