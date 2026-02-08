int splitArray(int* nums, int numsSize, int m) {
    int left = 0, right = 0;
    for (int i = 0; i < numsSize; i++) {
        left = left > nums[i] ? left : nums[i];
        right += nums[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int count = 1, sum = 0;
        for (int i = 0; i < numsSize; i++) {
            if (sum + nums[i] > mid) {
                count++;
                sum = nums[i];
            } else {
                sum += nums[i];
            }
        }

        if (count > m) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}