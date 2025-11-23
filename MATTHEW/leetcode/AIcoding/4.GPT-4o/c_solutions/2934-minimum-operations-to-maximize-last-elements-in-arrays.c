int minOperations(int* nums, int numsSize) {
    int maxElement = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxElement) {
            maxElement = nums[i];
        }
    }

    int operations = 0;
    for (int i = 0; i < numsSize; i++) {
        operations += maxElement - nums[i];
    }

    return operations;
}