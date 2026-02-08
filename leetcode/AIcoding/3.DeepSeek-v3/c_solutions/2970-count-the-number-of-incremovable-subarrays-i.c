int incremovableSubarrayCount(int* nums, int numsSize) {
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            int valid = 1;
            int prev = -1;

            for (int k = 0; k < numsSize && valid; k++) {
                if (k >= i && k <= j) continue;

                if (prev >= nums[k]) {
                    valid = 0;
                } else {
                    prev = nums[k];
                }
            }

            if (valid) count++;
        }
    }

    return count;
}