int minOperations(int* nums, int numsSize, int k) {
    int min_val = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min_val) {
            min_val = nums[i];
        }
    }

    if (min_val < k) {
        return -1;
    }

    int operations = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > k) {
            operations++;
        }
    }

    return operations;
}