int longestNiceSubarray(int* nums, int numsSize) {
    int left = 0;
    int usedBits = 0;
    int maxLen = 0;

    for (int right = 0; right < numsSize; right++) {
        while ((usedBits & nums[right]) != 0) {
            usedBits ^= nums[left];
            left++;
        }
        usedBits |= nums[right];
        if (right - left + 1 > maxLen) {
            maxLen = right - left + 1;
        }
    }

    return maxLen;
}