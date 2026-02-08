long long minIncrementOperations(int* nums, int numsSize, int k) {
    long long operations = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < k) {
            operations += (long long)k - nums[i];
        }
    }
    return operations;
}