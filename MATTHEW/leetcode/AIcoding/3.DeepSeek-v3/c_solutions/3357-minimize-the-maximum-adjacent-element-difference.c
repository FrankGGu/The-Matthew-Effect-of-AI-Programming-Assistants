int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int minimizeMax(int* nums, int numsSize, int p) {
    if (p == 0) return 0;

    qsort(nums, numsSize, sizeof(int), cmp);

    int left = 0, right = nums[numsSize - 1] - nums[0];

    while (left < right) {
        int mid = left + (right - left) / 2;

        int count = 0;
        for (int i = 1; i < numsSize && count < p; i++) {
            if (nums[i] - nums[i - 1] <= mid) {
                count++;
                i++;
            }
        }

        if (count >= p) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}