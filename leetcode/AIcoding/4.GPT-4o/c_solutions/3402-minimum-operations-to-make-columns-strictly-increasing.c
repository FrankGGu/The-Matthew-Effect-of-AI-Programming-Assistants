int minOperations(int** nums, int numsSize, int* numsColSize) {
    int operations = 0;
    for (int j = 0; j < numsColSize[0]; j++) {
        for (int i = 1; i < numsSize; i++) {
            if (nums[i][j] <= nums[i-1][j]) {
                operations += nums[i-1][j] - nums[i][j] + 1;
                nums[i][j] = nums[i-1][j] + 1;
            }
        }
    }
    return operations;
}