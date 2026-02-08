int findLengthOfLCIS(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int maxLength = 1;
    int currentLength = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i-1]) {
            currentLength++;
        } else {
            currentLength = 1;
        }
        if (currentLength > maxLength) {
            maxLength = currentLength;
        }
    }

    return maxLength;
}