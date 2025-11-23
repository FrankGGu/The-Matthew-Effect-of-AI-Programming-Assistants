int minCapability(int* nums, int numsSize, int k) {
    int left = 1, right = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) right = nums[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int count = 0;
        int i = 0;
        while (i < numsSize) {
            if (nums[i] <= mid) {
                count++;
                i += 2;
            } else {
                i++;
            }
        }

        if (count >= k) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}