int sumOfGoodNumbers(int* nums, int numsSize, int k) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        int good = 1;
        if (i - k >= 0 && nums[i] <= nums[i - k]) {
            good = 0;
        }
        if (i + k < numsSize && nums[i] <= nums[i + k]) {
            good = 0;
        }
        if (good) {
            sum += nums[i];
        }
    }
    return sum;
}