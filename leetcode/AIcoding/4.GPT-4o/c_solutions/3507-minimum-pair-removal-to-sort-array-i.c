int minPairSum(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int maxSum = 0;
    for (int i = 0; i < numsSize / 2; i++) {
        int pairSum = nums[i] + nums[numsSize - 1 - i];
        if (pairSum > maxSum) {
            maxSum = pairSum;
        }
    }
    return maxSum;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}