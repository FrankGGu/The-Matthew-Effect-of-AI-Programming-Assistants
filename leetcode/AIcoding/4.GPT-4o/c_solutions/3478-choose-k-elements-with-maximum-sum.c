int maxSum(int* nums, int numsSize, int k) {
    int sum = 0;
    // Sort the array in descending order
    qsort(nums, numsSize, sizeof(int), cmp);
    for (int i = 0; i < k; i++) {
        sum += nums[i];
    }
    return sum;
}

int cmp(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}