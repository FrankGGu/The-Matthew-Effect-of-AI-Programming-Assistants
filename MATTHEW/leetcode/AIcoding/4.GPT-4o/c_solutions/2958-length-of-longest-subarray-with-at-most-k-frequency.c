int longestSubarray(int* nums, int numsSize, int k) {
    int left = 0, right = 0, maxLength = 0;
    int count[100001] = {0};

    while (right < numsSize) {
        count[nums[right]]++;

        while (count[nums[right]] > k) {
            count[nums[left]]--;
            left++;
        }

        maxLength = fmax(maxLength, right - left + 1);
        right++;
    }

    return maxLength;
}