int countPairs(int* nums, int numsSize, int mid) {
    int count = 0, j = 0;
    for (int i = 0; i < numsSize; i++) {
        while (j < numsSize && nums[j] - nums[i] <= mid) {
            j++;
        }
        count += j - i - 1;
    }
    return count;
}

int smallestDistancePair(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), (int(*)(const void*, const void*)) cmp);
    int left = 0, right = nums[numsSize - 1] - nums[0];

    while (left < right) {
        int mid = left + (right - left) / 2;
        if (countPairs(nums, numsSize, mid) < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}

int cmp(const int* a, const int* b) {
    return *a - *b;
}