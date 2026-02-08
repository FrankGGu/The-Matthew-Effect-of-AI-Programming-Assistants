int maximumSum(int* nums, int numsSize) {
    int max_sum = -1;
    int sum_map[82] = {0}; // Since the max digit sum for 10^9 is 81

    for (int i = 0; i < numsSize; i++) {
        int sum = 0, temp = nums[i];
        while (temp > 0) {
            sum += temp % 10;
            temp /= 10;
        }
        if (sum_map[sum]) {
            max_sum = fmax(max_sum, sum_map[sum] + nums[i]);
            sum_map[sum] = fmax(sum_map[sum], nums[i]);
        } else {
            sum_map[sum] = nums[i];
        }
    }

    return max_sum;
}