int minSubArrayLen(int target, int* nums, int numsSize) {
    int left = 0, sum = 0, min_length = INT_MAX;

    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];

        while (sum >= target) {
            min_length = fmin(min_length, right - left + 1);
            sum -= nums[left++];
        }
    }

    return min_length == INT_MAX ? 0 : min_length;
}