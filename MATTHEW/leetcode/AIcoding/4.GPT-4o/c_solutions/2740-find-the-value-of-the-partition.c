int findValueOfPartition(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int minDifference = INT_MAX;
    for (int i = 1; i < numsSize; i++) {
        int difference = nums[i] - nums[i - 1];
        if (difference < minDifference) {
            minDifference = difference;
        }
    }
    return minDifference;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}