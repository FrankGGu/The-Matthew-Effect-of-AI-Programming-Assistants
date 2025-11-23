int minOperations(int* nums, int numsSize) {
    int minVal = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minVal) {
            minVal = nums[i];
        }
    }
    int operations = 0;
    for (int i = 0; i < numsSize; i++) {
        operations += nums[i] - minVal;
    }
    return operations;
}