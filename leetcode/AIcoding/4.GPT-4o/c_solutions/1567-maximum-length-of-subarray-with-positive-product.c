int getMaxLen(int* nums, int numsSize) {
    int maxLength = 0, positiveLength = 0, negativeLength = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            positiveLength++;
            negativeLength = negativeLength > 0 ? negativeLength + 1 : 0;
        } else if (nums[i] < 0) {
            int temp = positiveLength;
            positiveLength = negativeLength > 0 ? negativeLength + 1 : 0;
            negativeLength = temp + 1;
        } else {
            positiveLength = 0;
            negativeLength = 0;
        }
        maxLength = maxLength > positiveLength ? maxLength : positiveLength;
    }

    return maxLength;
}