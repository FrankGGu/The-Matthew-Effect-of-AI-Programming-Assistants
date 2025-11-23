int minOperations(int* nums, int numsSize, int k) {
    int operations = 0;
    for (int i = 0; i < numsSize; i++) {
        operations += abs(nums[i] - k);
    }
    return operations;
}