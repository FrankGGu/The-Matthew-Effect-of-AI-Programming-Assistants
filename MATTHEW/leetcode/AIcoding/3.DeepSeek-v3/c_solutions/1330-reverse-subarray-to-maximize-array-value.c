int maxValueAfterReverse(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        total += abs(nums[i] - nums[i + 1]);
    }

    int res = total;

    for (int i = 0; i < numsSize - 1; i++) {
        if (i > 0) {
            res = fmax(res, total - abs(nums[i] - nums[i + 1]) + abs(nums[0] - nums[i + 1]));
            res = fmax(res, total - abs(nums[i] - nums[i + 1]) + abs(nums[i] - nums[numsSize - 1]));
        }
    }

    int maxMin = INT_MIN;
    int minMax = INT_MAX;

    for (int i = 0; i < numsSize - 1; i++) {
        int a = nums[i];
        int b = nums[i + 1];
        maxMin = fmax(maxMin, fmin(a, b));
        minMax = fmin(minMax, fmax(a, b));
    }

    res = fmax(res, total + 2 * (maxMin - minMax));

    return res;
}