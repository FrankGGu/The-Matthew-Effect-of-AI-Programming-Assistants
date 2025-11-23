int longestSubarray(int* nums, int numsSize) {
    int maxAnd = 0, maxLength = 0, currentLength = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxAnd) {
            maxAnd = nums[i];
            currentLength = 1;
        } else if (nums[i] == maxAnd) {
            currentLength++;
        } else {
            currentLength = 0;
        }
        if (currentLength > maxLength) {
            maxLength = currentLength;
        }
    }

    return maxLength;
}