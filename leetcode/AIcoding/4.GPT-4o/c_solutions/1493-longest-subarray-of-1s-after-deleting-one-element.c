int longestSubarray(int* nums, int numsSize) {
    int left = 0, right = 0, zeroCount = 0, maxLength = 0;

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

        maxLength = fmax(maxLength, right - left);
        right++;
    }

    return maxLength;
}