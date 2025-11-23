int minimumTime(int* nums, int numsSize) {
    int max = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max) {
            max = nums[i];
        }
    }

    int left = 0, right = max;
    while (left < right) {
        int mid = left + (right - left) / 2;
        long long total = 0;
        for (int i = 0; i < numsSize; i++) {
            total += (mid + nums[i]) / nums[i];
        }
        if (total >= numsSize) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}