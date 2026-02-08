int longestContinuousIncreasingSubsequence(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    int maxLen = 1, currentLen = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i - 1]) {
            currentLen++;
        } else {
            if (currentLen > maxLen) {
                maxLen = currentLen;
            }
            currentLen = 1;
        }
    }

    return currentLen > maxLen ? currentLen : maxLen;
}