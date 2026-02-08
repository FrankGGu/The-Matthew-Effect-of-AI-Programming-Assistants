int min(int a, int b) {
    return a < b ? a : b;
}

int minSizeSubarray(int* nums, int numsSize, int target) {
    long long total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    int full_arrays = target / total;
    long long remaining = target % total;

    if (remaining == 0) {
        return full_arrays * numsSize;
    }

    int min_len = numsSize * 2 + 1;
    long long sum = 0;
    int left = 0;

    for (int right = 0; right < numsSize * 2; right++) {
        sum += nums[right % numsSize];

        while (sum > remaining) {
            sum -= nums[left % numsSize];
            left++;
        }

        if (sum == remaining) {
            min_len = min(min_len, right - left + 1);
        }
    }

    return min_len == numsSize * 2 + 1 ? -1 : full_arrays * numsSize + min_len;
}