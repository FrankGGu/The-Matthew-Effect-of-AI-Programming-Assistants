int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int smallestRangeII(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int ans = nums[numsSize - 1] - nums[0];

    for (int i = 0; i < numsSize - 1; i++) {
        int high = fmax(nums[numsSize - 1] - k, nums[i] + k);
        int low = fmin(nums[0] + k, nums[i + 1] - k);
        ans = fmin(ans, high - low);
    }

    return ans;
}