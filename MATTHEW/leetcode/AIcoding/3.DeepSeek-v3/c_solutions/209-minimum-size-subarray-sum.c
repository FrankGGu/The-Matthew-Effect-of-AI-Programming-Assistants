int minSubArrayLen(int target, int* nums, int numsSize) {
    int left = 0, sum = 0;
    int min_len = numsSize + 1;

    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];

        while (sum >= target) {
            int current_len = right - left + 1;
            if (current_len < min_len) {
                min_len = current_len;
            }
            sum -= nums[left];
            left++;
        }
    }

    return min_len == numsSize + 1 ? 0 : min_len;
}