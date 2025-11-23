int minOperations(int* nums, int numsSize, int threshold) {
    int sum = 0, operations = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    while (sum <= threshold) {
        sum += 1;
        operations++;
    }

    return operations;
}