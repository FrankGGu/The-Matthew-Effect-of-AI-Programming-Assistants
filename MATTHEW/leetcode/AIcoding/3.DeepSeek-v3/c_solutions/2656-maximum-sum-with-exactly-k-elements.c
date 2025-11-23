int maximizeSum(int* nums, int numsSize, int k) {
    int max = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > max) {
            max = nums[i];
        }
    }
    return max * k + k * (k - 1) / 2;
}