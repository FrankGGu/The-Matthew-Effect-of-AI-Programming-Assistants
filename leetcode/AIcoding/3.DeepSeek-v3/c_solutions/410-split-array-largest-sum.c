int splitArray(int* nums, int numsSize, int k) {
    long long left = 0, right = 0;
    for (int i = 0; i < numsSize; i++) {
        right += nums[i];
        if (nums[i] > left) left = nums[i];
    }

    while (left < right) {
        long long mid = left + (right - left) / 2;
        int count = 1;
        long long current = 0;

        for (int i = 0; i < numsSize; i++) {
            if (current + nums[i] > mid) {
                count++;
                current = nums[i];
            } else {
                current += nums[i];
            }
        }

        if (count > k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}