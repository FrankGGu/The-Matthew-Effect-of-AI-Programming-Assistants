int minSubArrayLen(int target, int* nums, int numsSize) {
    int left = 0, sum = 0, minLen = INT_MAX;

    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];

        while (sum >= target) {
            minLen = fmin(minLen, right - left + 1);
            sum -= nums[left++];
        }
    }

    return minLen == INT_MAX ? 0 : minLen;
}