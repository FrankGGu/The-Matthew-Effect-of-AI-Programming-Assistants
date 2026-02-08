int minOperations(int* nums, int numsSize) {
    int operations = 0;
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    while (total > 0) {
        operations++;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] > 0) {
                total -= 1;
                nums[i] -= 1;
            }
        }
    }
    return operations;
}