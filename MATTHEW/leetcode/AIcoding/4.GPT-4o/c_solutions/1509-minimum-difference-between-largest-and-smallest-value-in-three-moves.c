int minimumDifference(int* nums, int numsSize) {
    if (numsSize <= 4) return 0;

    qsort(nums, numsSize, sizeof(int), cmp);
    int minDiff = INT_MAX;

    for (int i = 0; i <= 3; i++) {
        minDiff = fmin(minDiff, nums[numsSize - 4 + i] - nums[i]);
    }

    return minDiff;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}