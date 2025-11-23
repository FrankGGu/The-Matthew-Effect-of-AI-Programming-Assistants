int maximumTop(int* nums, int numsSize, int k) {
    if (k == 0) return nums[0];
    if (k >= numsSize) {
        int maxVal = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] > maxVal) maxVal = nums[i];
        }
        return maxVal;
    }
    int maxVal = 0;
    for (int i = 0; i < numsSize && i < k + 1; i++) {
        if (i != k) {
            if (nums[i] > maxVal) maxVal = nums[i];
        }
    }
    return maxVal;
}