int maxSubarraySumCircular(int* nums, int numsSize) {
    int total = 0, maxKadane = nums[0], minKadane = nums[0], currentMax = 0, currentMin = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];

        currentMax = currentMax > 0 ? currentMax + nums[i] : nums[i];
        maxKadane = maxKadane > currentMax ? maxKadane : currentMax;

        currentMin = currentMin < 0 ? currentMin + nums[i] : nums[i];
        minKadane = minKadane < currentMin ? minKadane : currentMin;
    }

    if (maxKadane < 0) return maxKadane;

    return max(maxKadane, total - minKadane);
}

int max(int a, int b) {
    return a > b ? a : b;
}