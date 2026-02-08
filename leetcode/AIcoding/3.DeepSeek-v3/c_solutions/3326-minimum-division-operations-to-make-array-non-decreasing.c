int minimumOperations(int* nums, int numsSize) {
    int operations = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[i - 1]) {
            operations++;
            nums[i] = nums[i - 1];
        }
    }
    return operations;
}