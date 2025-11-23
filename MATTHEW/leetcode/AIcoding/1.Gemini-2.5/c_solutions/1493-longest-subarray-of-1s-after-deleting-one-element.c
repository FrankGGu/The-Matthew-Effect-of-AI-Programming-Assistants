int longestSubarray(int* nums, int numsSize) {
    int left = 0;
    int right = 0;
    int zeroCount = 0;
    int maxLength = 0;

    while (right < numsSize) {
        if (nums[right] == 0) {
            zeroCount++;
        }

        while (zeroCount > 1) {
            if (nums[left] == 0) {
                zeroCount--;
            }
            left++;
        }

        if (zeroCount <= 1) {
            maxLength = (right - left > maxLength) ? (right - left) : maxLength;
        }
        right++;
    }

    return maxLength;
}