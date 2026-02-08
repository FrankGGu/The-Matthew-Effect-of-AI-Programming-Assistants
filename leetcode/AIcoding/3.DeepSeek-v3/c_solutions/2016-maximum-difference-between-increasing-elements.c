int maximumDifference(int* nums, int numsSize) {
    int min_val = nums[0];
    int max_diff = -1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > min_val) {
            int diff = nums[i] - min_val;
            if (diff > max_diff) {
                max_diff = diff;
            }
        } else {
            min_val = nums[i];
        }
    }

    return max_diff;
}