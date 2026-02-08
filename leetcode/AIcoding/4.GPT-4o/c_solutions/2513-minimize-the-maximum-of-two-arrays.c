int minimizeArrayValue(int* nums, int numsSize) {
    long sum = 0;
    int maxValue = 0;

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        maxValue = maxValue < nums[i] ? nums[i] : maxValue;
        if ((sum + i) / (i + 1) > maxValue) {
            maxValue = (sum + i) / (i + 1);
        }
    }

    return maxValue;
}