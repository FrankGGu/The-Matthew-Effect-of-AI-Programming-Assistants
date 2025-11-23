int maxValueAfterReverse(int* nums, int numsSize) {
    int maxVal = 0, maxDiff = 0, minDiff = 0, total = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        total += abs(nums[i] - nums[i + 1]);
    }
    maxVal = total;
    for (int i = 0; i < numsSize - 1; i++) {
        int leftMax = i > 0 ? fmax(nums[i], nums[i + 1]) : nums[i + 1];
        int rightMax = i < numsSize - 2 ? fmax(nums[i + 1], nums[i + 2]) : nums[i];
        maxDiff = fmax(maxDiff, rightMax - nums[i + 1]);
        minDiff = fmin(minDiff, leftMax - nums[i]);
    }
    return maxVal + maxDiff + minDiff;
}