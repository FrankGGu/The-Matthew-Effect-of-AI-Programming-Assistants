int dominantIndex(int* nums, int numsSize) {
    if (numsSize == 0) {
        return -1;
    }
    if (numsSize == 1) {
        return 0;
    }

    int max1 = -1;
    int max2 = -1;
    int max1_idx = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max1) {
            max2 = max1;
            max1 = nums[i];
            max1_idx = i;
        } else if (nums[i] > max2) {
            max2 = nums[i];
        }
    }

    if (max1 >= 2 * max2) {
        return max1_idx;
    } else {
        return -1;
    }
}