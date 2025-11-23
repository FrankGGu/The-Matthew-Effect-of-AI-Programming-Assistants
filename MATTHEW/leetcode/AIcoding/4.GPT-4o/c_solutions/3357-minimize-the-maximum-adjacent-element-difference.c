int minimizeMax(int* nums, int numsSize) {
    int left = 0, right = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] - nums[i - 1] > right) {
            right = nums[i] - nums[i - 1];
        }
    }
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (canAchieve(nums, numsSize, mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}

bool canAchieve(int* nums, int numsSize, int limit) {
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] - nums[i - 1] > limit) {
            int diff = nums[i] - nums[i - 1] - limit;
            if (i < numsSize - 1) {
                nums[i] += diff;
            } else {
                return false;
            }
        }
    }
    return true;
}