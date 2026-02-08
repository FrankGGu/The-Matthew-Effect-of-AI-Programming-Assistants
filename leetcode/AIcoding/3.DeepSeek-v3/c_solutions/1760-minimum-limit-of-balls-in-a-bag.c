int minimumSize(int* nums, int numsSize, int maxOperations) {
    int left = 1, right = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) right = nums[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int ops = 0;

        for (int i = 0; i < numsSize; i++) {
            ops += (nums[i] - 1) / mid;
        }

        if (ops <= maxOperations) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}