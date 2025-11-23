int cmp(const void *a, const void *b) {
    return *(long long*)a - *(long long*)b;
}

long long countFairPairs(int* nums, int numsSize, int lower, int upper) {
    long long *arr = (long long*)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        arr[i] = (long long)nums[i];
    }
    qsort(arr, numsSize, sizeof(long long), cmp);

    long long count = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        long long low_bound = lower - arr[i];
        long long up_bound = upper - arr[i];

        int left = i + 1, right = numsSize - 1;
        int low_idx = -1, up_idx = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] >= low_bound) {
                low_idx = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        left = i + 1;
        right = numsSize - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] <= up_bound) {
                up_idx = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (low_idx != -1 && up_idx != -1 && low_idx <= up_idx) {
            count += (up_idx - low_idx + 1);
        }
    }

    free(arr);
    return count;
}