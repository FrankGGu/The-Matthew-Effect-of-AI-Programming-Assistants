int maxFrequency(int* nums, int numsSize, int k) {
    int left = 0, total = 0, maxFreq = 0;
    qsort(nums, numsSize, sizeof(int), cmp);

    for (int right = 0; right < numsSize; right++) {
        total += nums[right];

        while (nums[right] * (right - left + 1) - total > k) {
            total -= nums[left];
            left++;
        }

        maxFreq = fmax(maxFreq, right - left + 1);
    }

    return maxFreq;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}