int longestAlternatingSubarray(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    int maxLength = 1, currentLength = 1;

    for (int i = 1; i < numsSize; i++) {
        if ((nums[i] - nums[i - 1]) * (i % 2 == 0 ? 1 : -1) > 0) {
            currentLength++;
        } else {
            maxLength = maxLength > currentLength ? maxLength : currentLength;
            currentLength = 1;
        }
    }

    return maxLength > currentLength ? maxLength : currentLength;
}