int longestNonDecreasingArray(int* nums, int numsSize) {
    int maxLength = 1, currentLength = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] >= nums[i - 1]) {
            currentLength++;
        } else {
            if (currentLength > maxLength) {
                maxLength = currentLength;
            }
            currentLength = 1;
        }
    }
    if (currentLength > maxLength) {
        maxLength = currentLength;
    }
    return maxLength;
}