int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int countPairs(int* nums, int numsSize, int mid) {
    int count = 0;
    int j = 0;
    for (int i = 0; i < numsSize; i++) {
        while (j < numsSize && nums[j] - nums[i] <= mid) {
            j++;
        }
        count += j - i - 1;
    }
    return count;
}

int smallestDistancePair(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int left = 0;
    int right = nums[numsSize - 1] - nums[0];

    while (left < right) {
        int mid = left + (right - left) / 2;
        int count = countPairs(nums, numsSize, mid);

        if (count < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}