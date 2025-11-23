long long maximumOr(int* nums, int numsSize, int k) {
    long long *prefix = (long long*)malloc((numsSize + 1) * sizeof(long long));
    long long *suffix = (long long*)malloc((numsSize + 1) * sizeof(long long));

    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] | (long long)nums[i];
    }

    suffix[numsSize] = 0;
    for (int i = numsSize - 1; i >= 0; i--) {
        suffix[i] = suffix[i + 1] | (long long)nums[i];
    }

    long long max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        long long doubled = (long long)nums[i] << k;
        long long current = prefix[i] | doubled | suffix[i + 1];
        if (current > max_val) {
            max_val = current;
        }
    }

    free(prefix);
    free(suffix);
    return max_val;
}