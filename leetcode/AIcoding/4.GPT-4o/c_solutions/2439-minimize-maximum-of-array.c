int minimizeArrayValue(int* nums, int numsSize) {
    long long total = 0;
    int maxValue = 0;

    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
        maxValue = (maxValue > nums[i]) ? maxValue : nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < maxValue) {
            long long required = (long long) numsSize * maxValue - total;
            if (required <= 0) return maxValue;
            if (required > nums[i]) {
                total += (maxValue - nums[i]);
                nums[i] = maxValue;
            }
        }
    }

    return maxValue;
}