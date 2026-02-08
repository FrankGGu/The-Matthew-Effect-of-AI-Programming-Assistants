int maximumCount(int* nums, int numsSize) {
    int positiveCount = 0;
    int negativeCount = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            positiveCount++;
        } else if (nums[i] < 0) {
            negativeCount++;
        }
    }

    return positiveCount > negativeCount ? positiveCount : negativeCount;
}