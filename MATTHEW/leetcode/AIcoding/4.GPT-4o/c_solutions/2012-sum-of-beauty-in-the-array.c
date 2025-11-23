int sumOfBeauty(int* nums, int numsSize) {
    int beautySum = 0;
    for (int i = 1; i < numsSize - 1; i++) {
        int leftMax = nums[i - 1];
        int rightMax = nums[i + 1];
        if (nums[i] > leftMax && nums[i] > rightMax) {
            beautySum += 2;
        } else if (nums[i] < leftMax && nums[i] < rightMax) {
            beautySum += 2;
        } else if (nums[i] > leftMax || nums[i] > rightMax || nums[i] < leftMax || nums[i] < rightMax) {
            beautySum += 1;
        }
    }
    return beautySum;
}