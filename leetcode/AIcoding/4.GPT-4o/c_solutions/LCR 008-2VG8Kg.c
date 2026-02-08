int minSubArrayLen(int target, int* nums, int numsSize) {
    int left = 0, sum = 0, minLength = INT_MAX;
    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];
        while (sum >= target) {
            minLength = fmin(minLength, right - left + 1);
            sum -= nums[left++];
        }
    }
    return minLength == INT_MAX ? 0 : minLength;
}