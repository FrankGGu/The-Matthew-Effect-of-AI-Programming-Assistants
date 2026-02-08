int maxSum(int* nums, int numsSize, int k) {
    int max_sum = 0, current_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        current_sum += nums[i];
        if (i >= k) {
            current_sum -= nums[i - k];
        }
        if (i >= k - 1) {
            max_sum = (current_sum > max_sum) ? current_sum : max_sum;
        }
    }
    return max_sum;
}