int longestEvenOddSubarray(int* nums, int numsSize, int threshold) {
    int maxLength = 0, currentLength = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] <= threshold) {
            if (i == 0 || (nums[i] % 2) != (nums[i - 1] % 2)) {
                currentLength++;
            } else {
                currentLength = 1;
            }
            if (currentLength > maxLength) {
                maxLength = currentLength;
            }
        } else {
            currentLength = 0;
        }
    }
    return maxLength;
}