int smallestRangeI(int* nums, int numsSize, int k) {
    int min_val = nums[0];
    int max_val = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min_val) min_val = nums[i];
        if (nums[i] > max_val) max_val = nums[i];
    }

    int diff = max_val - min_val - 2 * k;
    return diff > 0 ? diff : 0;
}