int maxSum(int* nums, int numsSize, int k, int m) {
    int max_sum = 0, current_sum = 0, sum_k = 0;
    int min_prefix_sum = 0;
    int* prefix = (int*)malloc((numsSize + 1) * sizeof(int));
    prefix[0] = 0;

    for (int i = 0; i < numsSize; i++) {
        current_sum += nums[i];
        prefix[i + 1] = current_sum;

        if (i >= k - 1) {
            sum_k = current_sum - prefix[i - k + 1];
            if (i >= m - 1) {
                min_prefix_sum = fmin(min_prefix_sum, prefix[i - m + 1]);
                max_sum = fmax(max_sum, sum_k + min_prefix_sum);
            }
        }
    }

    free(prefix);
    return max_sum;
}