long long maxArrayValue(int* nums, int numsSize) {
    long long sum = nums[numsSize - 1];
    long long max = sum;

    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] <= sum) {
            sum += nums[i];
        } else {
            sum = nums[i];
        }
        if (sum > max) {
            max = sum;
        }
    }

    return max;
}