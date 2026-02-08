int maximizeMinimum(int* nums, int numsSize, int p) {
    int left = 0, right = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) right = nums[i];
    }

    while (left < right) {
        int mid = left + (right - left + 1) / 2;
        int count = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] >= mid) {
                count++;
            } else {
                count = count > 0 ? count - 1 : 0;
            }
            if (count >= p) break;
        }

        if (count >= p) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
}