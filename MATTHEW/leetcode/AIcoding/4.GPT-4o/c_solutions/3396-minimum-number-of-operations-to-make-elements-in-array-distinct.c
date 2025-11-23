int minOperations(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int operations = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= nums[i - 1]) {
            operations += (nums[i - 1] - nums[i] + 1);
            nums[i] = nums[i - 1] + 1;
        }
    }
    return operations;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}