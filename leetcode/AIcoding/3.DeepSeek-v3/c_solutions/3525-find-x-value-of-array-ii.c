int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int findXValue(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    long long left = nums[0], right = nums[numsSize - 1];
    long long ans = left;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long total = 0;
        for (int i = 0; i < numsSize; i++) {
            total += (nums[i] < mid) ? nums[i] : mid;
        }

        if (2 * total <= sum) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}