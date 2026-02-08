int cmp(const void *a, const void *b) {
    return *(long long*)a - *(long long*)b;
}

int maxFrequency(int* nums, int numsSize, int k, int t) {
    long long *arr = (long long*)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        arr[i] = nums[i];
    }
    qsort(arr, numsSize, sizeof(long long), cmp);

    long long left = 0;
    long long total_ops = 0;
    long long max_freq = 1;

    for (long long right = 1; right < numsSize; right++) {
        total_ops += (arr[right] - arr[right - 1]) * (right - left);

        while (total_ops > (long long)k + (long long)t * (right - left)) {
            total_ops -= arr[right] - arr[left];
            left++;
        }

        if (right - left + 1 > max_freq) {
            max_freq = right - left + 1;
        }
    }

    free(arr);
    return max_freq;
}