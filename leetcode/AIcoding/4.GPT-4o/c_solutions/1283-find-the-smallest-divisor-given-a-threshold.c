int sum_with_divisor(int* nums, int size, int divisor) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += (nums[i] + divisor - 1) / divisor;
    }
    return sum;
}

int smallestDivisor(int* nums, int numsSize, int threshold) {
    int left = 1, right = 1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) {
            right = nums[i];
        }
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        if (sum_with_divisor(nums, numsSize, mid) > threshold) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}