int longestNiceSubarray(int* nums, int numsSize) {
    int left = 0, maxLength = 0, currentMask = 0;

    for (int right = 0; right < numsSize; right++) {
        while ((currentMask & nums[right]) != 0) {
            currentMask ^= nums[left];
            left++;
        }
        currentMask |= nums[right];
        maxLength = fmax(maxLength, right - left + 1);
    }

    return maxLength;
}